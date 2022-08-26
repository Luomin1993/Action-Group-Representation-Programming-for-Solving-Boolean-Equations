# -*- coding: utf-8 -*-
"""
Created on Thu June 29 21:09:39 2022

@author: Hanss401
"""
import numpy as np;
import re;
from keras.layers import Input;
from keras import layers,Model,models,utils;
from keras.models import Model, load_model;
from keras.models import Sequential;
from keras import layers,Model,models,utils;
from keras import backend as K;
from keras.layers.recurrent import GRU;
from tensorflow.keras import optimizers;
from keras import losses;
import matplotlib.pyplot as plt;
import keras;
import sys;

# ========= define evaluation ==========
def mean_pred(y_true, y_pred):
    return K.square(y_pred-y_true);    

# ========= define task func ===========
def task_finish(y_true, y_pred):
    return K.mean(K.greater(K.dot(K.softmax(y_pred), K.transpose(y_true)),.3), axis=-1)

# ========= load dataset ================
DAT_STATE_ACTIONS   = np.load('DAT_COEFF_MAT_VALUE_FIELD/DAT_STATE_ACTIONS.npy',allow_pickle=True);
DAT_STATE_CODE_NOW  = np.load('DAT_COEFF_MAT_VALUE_FIELD/DAT_STATE_CODE_NOW.npy',allow_pickle=True);
DAT_STATE_CODE_NEXT = np.load('DAT_COEFF_MAT_VALUE_FIELD/DAT_STATE_CODE_NEXT.npy',allow_pickle=True);

# print(DAT_STATE_ACTIONS.shape);print(DAT_STATE_CODE_NOW.shape);print(DAT_STATE_CODE_NEXT.shape);exit(1);

# ========= define constant data==========
DIM_INPUT_ACTION = 8;
DIM_STATE_CODE = 6;
DIM_MAT_ACTION = 6;

# ========= define Action Inputed ============
f_input_mat  = Input(shape=DIM_INPUT_ACTION, dtype='float32', name='f_input_mat'); # Mat inputed;
f_mat_in  = layers.Dense(16, activation='relu')(f_input_mat);
f_mat_in  = layers.Dense(32, activation='relu')(f_mat_in);
f_mat_in  = layers.Dense(16, activation='relu')(f_mat_in);
f_mat_in  = layers.Dense(DIM_MAT_ACTION*DIM_MAT_ACTION, activation='relu')(f_mat_in);
f_mat_out = layers.Reshape((DIM_MAT_ACTION, DIM_MAT_ACTION), input_shape=(DIM_MAT_ACTION*DIM_MAT_ACTION,))(f_mat_in); # REPRESENTATION output;
# ========= define State Inputed ============
f_input_state = Input(shape=DIM_STATE_CODE, dtype='float32', name='f_input_state'); # State inputed;
# ========= define State outputed ============
f_state_out = layers.Dot(1)([f_mat_out,f_input_state]); # State Next output;

# ========= define MODEL_AGRP_RHO ============
MODEL_AGRP_RHO = Model(inputs=[f_input_mat,f_input_state], outputs=f_state_out);
MODEL_AGRP_GR_MAT = Model(inputs=f_input_mat, outputs=f_mat_out);
sgd           = optimizers.SGD(learning_rate=0.001, decay=0.0, momentum=0.4, nesterov=True);
MODEL_AGRP_RHO.compile(optimizer=sgd, loss=losses.mean_squared_error, metrics=['mae']);

# ========= Training MODEL_AGRP_RHO ================
# MODEL_AGRP_RHO.fit([DAT_STATE_ACTIONS,DAT_STATE_CODE_NOW],DAT_STATE_CODE_NEXT,epochs=15,batch_size=30);
# MODEL_AGRP_RHO.save_weights('MODEL_AGRP_RHO_weights.h5');

# ========= Running MODEL_AGRP_RHO ================
# MODEL_AGRP_RHO.load_weights('MODEL_AGRP_RHO_weights.h5');
# DAT_STATE_CODE_NEXT_ = MODEL_AGRP_RHO.predict([DAT_STATE_ACTIONS[0:10],DAT_STATE_CODE_NOW[0:10]]);
# print(DAT_STATE_CODE_NEXT_);