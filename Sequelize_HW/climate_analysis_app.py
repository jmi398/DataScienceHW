
# coding: utf-8

# In[14]:


# Import Python SQL toolkit and Object Relational Mapper
import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, inspect, func, desc
import datetime as dt
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
# Import flask 
from flask import Flask, jsonify


# In[15]:


# Use create_engine to connect to your sqlite database
engine = create_engine("sqlite:///hawaii.sqlite", echo=False)

# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# Save a reference to those classes called Station and Measurement
Measurement = Base.classes.measurement
Station = Base.classes.station

# Create our session (link) from Python to the DB
session = Session(engine)


# In[16]:


# date 1 year ago from today
year_ago = dt.date.today() - dt.timedelta(days=365)
today = dt.date.today()


# In[17]:


# Flask Setup
app = Flask(__name__)

@app.route("/api/v1.0/precipitation")
def precipitation():
    # Query for precipitation
    results = session.query(Measurement.date, Measurement.prcp).    filter(Measurement.date > year_ago).    filter (Measurement.date < today).all()
    
    all_prcp = []  
    
    for item in results:
        prcp_dict = {}
        prcp_dict["date"] = item.date
        prcp_dict["prcp"] = item.prcp
        all_prcp.append(prcp_dict)    

    return jsonify(all_prcp)


# In[18]:


@app.route("/api/v1.0/stations")
def stations():
    
    results = session.query(Measurement.station).all()

    # Convert list of tuples into normal list
    all_stations = list(np.ravel(results))

    return jsonify(all_stations)


# In[ ]:


@app.route("/api/v1.0/<start>")
@app.route("/api/v1.0/<start>/<end>")
def temperature_start(start=None, end=None):
    if end==None:
        start_date = dt.datetime.strptime(start, '%Y-%m-%d')
        minimum_temp = session.query(func.min(Measurement.tobs)).                    filter(Measurement.date <= start).all()
        maximum_temp = session.query(func.max(Measurement.tobs)).                    filter(Measurement.date <= start).all()
        average_temp = session.query(func.avg(Measurement.tobs)).                    filter(Measurement.date <= start).all()
        temps2 = (minimum_temp[0], maximum_temp[0], average_temp[0])
        return jsonify(temps2)
    
    else:
        start_date = dt.datetime.strptime(start, '%Y-%m-%d')
        end_date = dt.datetime.strptime(end,'%Y-%m-%d')
        minimum_temp = session.query(func.min(Measurement.tobs)).                    filter(Measurement.date >= start).                    filter(Measurement.date <= end).all()
        maximum_temp = session.query(func.max(Measurement.tobs)).                    filter(Measurement.date >= start).                    filter(Measurement.date <= end).all()
        average_temp = session.query(func.avg(Measurement.tobs)).                    filter(Measurement.date >= start).        temps = (minimum_temp[0], maximum_temp[0], average_temp[0])
        return jsonify(temps) 
    
if __name__ == '__main__':
      app.run(debug=True)

