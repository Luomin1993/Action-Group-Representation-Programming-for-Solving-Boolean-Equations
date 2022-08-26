from sklearn.preprocessing import PolynomialFeatures;
import numpy as np;
from sklearn.linear_model import Perceptron;
from sklearn.linear_model import BayesianRidge;
from sklearn.pipeline import Pipeline;
from sklearn.linear_model import LinearRegression;
import pickle;

def output_processing_ml_bayesian(DAT_VALUE_PREDICTED):
    """ This function accelerating the outputs; """
    if len(DAT_VALUE_PREDICTED)==1: return (DAT_VALUE_PREDICTED[0]-0.18)*10.5-0.27;
    for INDEX_i in range(len(DAT_VALUE_PREDICTED)):
        DAT_VALUE_PREDICTED[INDEX_i] = (DAT_VALUE_PREDICTED[INDEX_i] - 0.18)*10.5-0.27;
    return DAT_VALUE_PREDICTED;

NUM_DATASET = 50;NUM_SAMPLES = 1000;
DAT_ML_HIDDEN_STATE_X = np.load('DAT_SP_POINTS_VALUE_FIELD/DAT_ML_HIDDEN_STATE_X.npy',allow_pickle=True);
DAT_VALUE = np.load('DAT_SP_POINTS_VALUE_FIELD/DAT_VALUE.npy',allow_pickle=True);

DAT_ML_HIDDEN_STATE_X = DAT_ML_HIDDEN_STATE_X[0:NUM_SAMPLES];DAT_VALUE = DAT_VALUE[0:NUM_SAMPLES];
DAT_VALUE = list(DAT_VALUE);DAT_VALUE = [VALUE[0] for VALUE in DAT_VALUE];

# ========= Training MODEL_ML_BAYESIAN_FITTER ================
# MODEL_ML_BAYESIAN_FITTER = BayesianRidge();
# MODEL_ML_BAYESIAN_FITTER.fit(DAT_ML_HIDDEN_STATE_X, DAT_VALUE);
# pickle.dump(MODEL_ML_BAYESIAN_FITTER, open("MODEL_ML_BAYESIAN_FITTER.sav", 'wb'));

# ========= Running MODEL_ML_BAYESIAN_FITTER ================
# MODEL_ML_BAYESIAN_FITTER = pickle.load(open("MODEL_ML_BAYESIAN_FITTER.sav", 'rb'));
# DAT_VALUE_PREDICTED = MODEL_ML_BAYESIAN_FITTER.predict(DAT_ML_HIDDEN_STATE_X);
# print(DAT_VALUE_PREDICTED);

# import matplotlib.pyplot as plt;
# from pylab import *;
# SOLV_POINTS = range(len(DAT_VALUE));
# DAT_VALUE_PREDICTED = output_processing_ml_bayesian(DAT_VALUE_PREDICTED);
# plt.plot(SOLV_POINTS, DAT_VALUE_PREDICTED, marker='o', mec='r', mfc='w',label=u'Solutions Value Field Predicted');
# plt.plot(SOLV_POINTS, DAT_VALUE, marker='x', mec='b', mfc='w',label=u'Solutions Value Field True');
# plt.ylim(-0.2, 1.1);plt.show();