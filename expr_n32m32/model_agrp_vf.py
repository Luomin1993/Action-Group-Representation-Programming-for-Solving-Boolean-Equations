import numpy as np;
import re;
from keras.layers import Input;
from keras import layers,Model,models,utils;
from keras.models import Model, load_model;
from keras.models import Sequential;
from keras import layers,Model,models,utils;
from keras import backend as K;
#from keras.layers.recurrent import GRU;
from tensorflow.keras import optimizers;
from keras import losses;
import matplotlib.pyplot as plt;
from keras.layers.merge import concatenate, add, maximum, subtract, multiply, dot;
import keras;
import sys;

def output_processing_cnn(DAT_VALUE_PREDICTED):
    """ This function accelerating the outputs; """
    if len(DAT_VALUE_PREDICTED)==1: return (DAT_VALUE_PREDICTED[0]-0.05)*13.5;
    MIN_OUT = min(DAT_VALUE_PREDICTED);MAX_OUT = max(DAT_VALUE_PREDICTED);MID_OUT = (MIN_OUT+MAX_OUT)/2;
    for INDEX_i in range(len(DAT_VALUE_PREDICTED)):
        DAT_VALUE_PREDICTED[INDEX_i] = (DAT_VALUE_PREDICTED[INDEX_i] - MIN_OUT)*13.5;
    return DAT_VALUE_PREDICTED;

def patch_mat_for_CNN(DAT_COEFF_MAT):
    DAT_ZERO_LINE = np.zeros((DAT_COEFF_MAT.shape[1],1));DAT_COEFF_MAT_NEW = [0]*DAT_COEFF_MAT.shape[0];
    for INDEX_i in range(DAT_COEFF_MAT.shape[0]):
        DAT_COEFF_MAT_NEW[INDEX_i] = np.append(DAT_ZERO_LINE,DAT_COEFF_MAT[INDEX_i],axis=1);
    return np.array(DAT_COEFF_MAT_NEW);

NUM_DATASET = 50;
DAT_COEFF_MAT   = np.load('DAT_COEFF_MAT_VALUE_FIELD/DAT_COEFF_MAT.npy',allow_pickle=True);
DAT_SOLV_POINTS = np.load('DAT_COEFF_MAT_VALUE_FIELD/DAT_SOLV.npy',allow_pickle=True);
DAT_VALUE       = np.load('DAT_COEFF_MAT_VALUE_FIELD/DAT_VALUE.npy',allow_pickle=True);

DAT_COEFF_MAT = patch_mat_for_CNN(DAT_COEFF_MAT);
# print(DAT_COEFF_MAT.shape);print(DAT_SOLV_POINTS.shape);print(DAT_VALUE.shape);exit(1);

DIM_INPUT_COEFF_MAT_1 = DAT_COEFF_MAT.shape[1];
DIM_INPUT_COEFF_MAT_2 = DAT_COEFF_MAT.shape[2];
DIM_INPUT_POINTS = 8;
DIM_HIDDEN_STATE = 6;
IMG_SHAPE = (DIM_INPUT_COEFF_MAT_1,DIM_INPUT_COEFF_MAT_2,1);

# ========= define Coeff Mat Inputed ============
f_input_mat = Input(shape=IMG_SHAPE, dtype='float32', name='f_input_mat') # Mat inputed;
f_mat_in    = layers.Conv2D(32,3,padding='same',activation='relu')(f_input_mat);
f_mat_in    = layers.Conv2D(24,3,padding='same',activation='relu',strides=2)(f_mat_in);
f_mat_in    = layers.Conv2D(16,3,padding='same',activation='relu',strides=2)(f_mat_in);
f_mat_in    = layers.Flatten()(f_mat_in);
f_mat_in    = layers.Dense(100, activation='relu')(f_mat_in);
f_mat_in    = layers.Dense(64, activation='relu')(f_mat_in);
f_mat_in    = layers.Dense(32, activation='relu')(f_mat_in);
# ========= define Coeff Mat Inputed ============
f_input_solv = Input(shape=DIM_INPUT_POINTS, dtype='float32', name='f_input_solv') # Point inputed;
f_solv_in    = layers.Dense(16, activation='relu')(f_input_solv);
f_solv_in    = layers.Dense(24, activation='relu')(f_solv_in);
f_solv_in    = layers.Dense(32, activation='relu')(f_solv_in);
# ========= define Hidden State ============
f_all_in    = add([f_solv_in,f_mat_in]);
f_all_in    = layers.Dense(24, activation='relu')(f_all_in);
f_all_in    = layers.Dense(16, activation='relu')(f_all_in);
f_all_in    = layers.Dense(8, activation='relu')(f_all_in);
f_state_out    = layers.Dense(6, activation='relu', name='f_state_out')(f_all_in); # Hidden State outputed;
# ========= define Outputed ============
f_state_in    = layers.Dense(4, activation='relu')(f_state_out);
f_value_out = layers.Dense(1)(f_state_in); # REWARD output;

# ========= define MODEL_AGRP_VALUE_FIELD ============
MODEL_AGRP_VALUE_FIELD = Model(inputs=[f_input_mat,f_input_solv], outputs=f_value_out);
MODEL_AGRP_HIDDEN_STATE = Model(inputs=[f_input_mat,f_input_solv], outputs=f_state_out);
MODEL_AGRP_STATE_TO_VALUE = Model(inputs=f_state_out, outputs=f_value_out);

sgd = optimizers.SGD(learning_rate=0.001, decay=0.1, momentum=0.5, nesterov=True);
MODEL_AGRP_VALUE_FIELD.compile(optimizer=sgd, loss=losses.mean_absolute_error, metrics=['mae']);

# ========= Training MODEL_AGRP_VALUE_FIELD ================
# history=MODEL_AGRP_VALUE_FIELD.fit([DAT_COEFF_MAT,DAT_SOLV_POINTS],DAT_VALUE,epochs=20,batch_size=10);
# MODEL_AGRP_VALUE_FIELD.save_weights('MODEL_AGRP_VALUE_FIELD_weights.h5');

# import matplotlib.pyplot as plt;
# history_dict = history.history;
# loss_values = history_dict["loss"];
# epochs = range(1, len(loss_values) + 1);
# plt.plot(epochs, loss_values, "bo", label="Training loss");
# plt.title("MODEL AGRP VALUE FIELD Training Loss");plt.xlabel("Epochs");plt.ylabel("Loss");
# plt.legend();plt.show();

# ========= Running MODEL_AGRP_VALUE_FIELD ================
MODEL_AGRP_VALUE_FIELD.load_weights('MODEL_AGRP_VALUE_FIELD_weights.h5');LEN_VALI = 2000;
DAT_VALUE_PREDICTED = MODEL_AGRP_VALUE_FIELD.predict([DAT_COEFF_MAT[0:LEN_VALI],DAT_SOLV_POINTS[0:LEN_VALI]]);

import matplotlib.pyplot as plt;
from pylab import *;

DAT_VALUE_PREDICTED = list(DAT_VALUE_PREDICTED); # Predicted VF;
DAT_VALUE_TRUE = list(DAT_VALUE); # True VF;
DAT_VALUE_PREDICTED = [DAT_VALUE_[0] for DAT_VALUE_ in DAT_VALUE_PREDICTED];
DAT_VALUE_PREDICTED = output_processing_cnn(DAT_VALUE_PREDICTED);
DAT_VALUE_TRUE = [DAT_VALUE_[0] for DAT_VALUE_ in DAT_VALUE[0:LEN_VALI]];
SOLV_POINTS = range(len(DAT_VALUE_PREDICTED));
plt.plot(SOLV_POINTS, DAT_VALUE_PREDICTED, marker='o', mec='r', mfc='w',label=u'Solutions Value Field Predicted');
plt.plot(SOLV_POINTS, DAT_VALUE_TRUE, marker='x', mec='b', mfc='w',label=u'Solutions Value Field True');
plt.ylim(-0.2, 1.1);
plt.legend();
plt.title("MODEL AGRP VALUE FIELD Fitting");plt.xlabel("Solution Space");plt.ylabel("Probability");
plt.show();

# ========= Make Dataset for MODEL_AGRP_RHO ================
# MODEL_AGRP_VALUE_FIELD.load_weights('MODEL_AGRP_VALUE_FIELD_weights.h5');
# DAT_HIDDEN_STATE_PREDICTED = MODEL_AGRP_HIDDEN_STATE.predict([DAT_COEFF_MAT,DAT_SOLV_POINTS]);
# NUM_UPPER_BOUND = 15000;DAT_STATE_ACTIONS = [];DAT_STATE_CODE_NOW = [];DAT_STATE_CODE_NEXT = [];
# for INDEX_i in range(DAT_HIDDEN_STATE_PREDICTED.shape[0]):
#     for INDEX_j in range(DAT_HIDDEN_STATE_PREDICTED.shape[0]):
#         if len(DAT_STATE_ACTIONS)>NUM_UPPER_BOUND:break;
#         if INDEX_i>=INDEX_j:continue;
#         if (False not in (DAT_SOLV_POINTS[INDEX_i] == DAT_SOLV_POINTS[INDEX_j])):continue;
#         DAT_STATE_CODE_NOW.append(DAT_HIDDEN_STATE_PREDICTED[INDEX_i]);
#         DAT_STATE_CODE_NEXT.append(DAT_HIDDEN_STATE_PREDICTED[INDEX_j]);
#         VEC_ACTION = [ (DAT_SOLV_POINTS[INDEX_i][INDEX_k] + DAT_SOLV_POINTS[INDEX_j][INDEX_k])%2 for INDEX_k in range(DAT_SOLV_POINTS.shape[1])];
#         DAT_STATE_ACTIONS.append(VEC_ACTION);
# np.save("DAT_COEFF_MAT_VALUE_FIELD/DAT_STATE_ACTIONS",np.array(DAT_STATE_ACTIONS,dtype=float));
# np.save("DAT_COEFF_MAT_VALUE_FIELD/DAT_STATE_CODE_NOW",np.array(DAT_STATE_CODE_NOW,dtype=float));
# np.save("DAT_COEFF_MAT_VALUE_FIELD/DAT_STATE_CODE_NEXT",np.array(DAT_STATE_CODE_NEXT,dtype=float));