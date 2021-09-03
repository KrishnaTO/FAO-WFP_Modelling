#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Apr  6 22:38:25 2020

@author: agar2
"""

import os; os.getcwd()
os.chdir('/home/agar2/Documents/WFP')

"""
# Download and unzip dataset

import urllib.request
import zipfile

urllib.request.urlretrieve("http://fenixservices.fao.org/faostat/static/bulkdownloads/Production_Crops_E_All_Data.zip", 
                           "/home/agar2/Documents/WFP/Production Crops.zip")

zipfile.ZipFile("/home/agar2/Documents/WFP/Production Crops.zip","r").extractall()

"""

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

prod = pd.read_csv("Production_Crops_E_All_Data_NOFLAG.csv", encoding="ISO-8859-1")
prod = prod.drop(['Area Code', 'Item Code', 'Element Code'], axis=1)


## Determine 'Element' with most observations
# Filter Element, count n (not in Area, Item, Unit)

prod2 = prod.drop(['Area', 'Item', 'Unit'], axis=1).groupby('Element').count()
# prod2 = prod.drop(['Area', 'Item', 'Unit'], axis=1).groupby('Element').describe()

prod2.sum().max()       #47402
prod2.sum()[prod2.sum()==47402]     #Y2014
# The max number of observations were in Y2014

# Plot graph of counts per grouping variable
prod2.transpose().plot()

## Determined that 'Element'=='Production' had most counts for all years (columns). 

prod3 = prod[prod['Element']=='Production']
prod3['Unit'].unique()      # Confirm there aren't additional units other than 'tonnes'
prod3=prod3.drop(['Element', 'Unit'], axis=1)

prod3['Item'].nunique()     # 181 'Items' in columns

prod3.to_csv("Production_Crops_Pivot.csv")

## Plot the Year by Value plot for the 181 items available. 

# prod3.groupby(['Area', 'Item']).describe()        ## Too computationally expensive
# prod3.groupby(['Area']).plot(legend=False)        ## Creates too many graphs
prod3_1 = prod3[prod['Area']=='Afghanistan'].drop('Area', axis=1)

prod3_1.to_csv("Production_Crops_Pivot_Afghanistan.csv")
# # Possible: 1) Index to column 'Item
# f, ax1 = plt.subplots()
# prod3_1.plot(ax=ax1, index=False)
# plt.legend(ncol=4, loc='best')

"""
fig1, ax1 = plt.subplots()
df.plot(color=colors, ax=ax1)
plt.legend(ncol=4, loc='best')
"""