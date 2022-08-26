from sklearn.preprocessing import PolynomialFeatures;
import numpy as np;
from sklearn.linear_model import Perceptron;
from sklearn.pipeline import Pipeline;
from sklearn.linear_model import LinearRegression;
import pickle;

NUM_DATASET = 50;NUM_SAMPLES = 1000;NUM_DEG = 2;
DAT_ML_HIDDEN_STATE_X = np.load('DAT_SP_POINTS_VALUE_FIELD/DAT_ML_HIDDEN_STATE_X.npy',allow_pickle=True);
DAT_VALUE = np.load('DAT_SP_POINTS_VALUE_FIELD/DAT_VALUE.npy',allow_pickle=True);

DAT_ML_HIDDEN_STATE_X = DAT_ML_HIDDEN_STATE_X[0:NUM_SAMPLES];DAT_VALUE = DAT_VALUE[0:NUM_SAMPLES];

DAT_VALUE = list(DAT_VALUE);DAT_VALUE = [RAND_Y[0] for RAND_Y in DAT_VALUE];
PF_PROCESSOR = PolynomialFeatures(degree=NUM_DEG);
DAT_ML_HIDDEN_STATE_X   = PF_PROCESSOR.fit_transform(DAT_ML_HIDDEN_STATE_X);

# ========= Training MODEL_ML_POLY_FITTER ================
# model = Pipeline([('poly', PolynomialFeatures(degree=NUM_DEG)),('linear', LinearRegression(fit_intercept=False))]);

# MODEL_ML_POLY_FITTER = model.fit(DAT_ML_HIDDEN_STATE_X, DAT_VALUE);
# pickle.dump(MODEL_ML_POLY_FITTER, open("MODEL_ML_POLY_FITTER.sav", 'wb'));

# ========= Running MODEL_ML_POLY_FITTER ================
# MODEL_ML_POLY_FITTER = pickle.load(open("MODEL_ML_POLY_FITTER.sav", 'rb'));
# DAT_RAND_Y_ = MODEL_ML_POLY_FITTER.predict(DAT_ML_HIDDEN_STATE_X);
# print(DAT_RAND_Y_);

# import matplotlib.pyplot as plt;
# from pylab import *;
# SOLV_POINTS = range(len(DAT_VALUE));
# plt.plot(SOLV_POINTS, DAT_RAND_Y_, marker='o', mec='r', mfc='w',label=u'Solutions Value Field Predicted');
# plt.plot(SOLV_POINTS, DAT_VALUE, marker='x', mec='b', mfc='w',label=u'Solutions Value Field True');
# plt.ylim(-0.2, 1.1);plt.show();