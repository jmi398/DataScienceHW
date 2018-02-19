

```python
# Import Dependencies
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
```


```python
# File to Load (Remember to Change These)
city_data_to_load = "city_data.csv"
ride_data_to_load = "ride_data.csv"

# Read data & store into pandas dataframe
City_df = pd.read_csv("city_data.csv")
Ride_df = pd.read_csv("ride_data.csv")

# Combine the data into a single dataset
ride_data_complete = pd.merge(Ride_df,City_df, how="inner", on=["city","city"])
# ride_data_complete.set_index('city')
ride_data_complete.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>city</th>
      <th>date</th>
      <th>fare</th>
      <th>ride_id</th>
      <th>driver_count</th>
      <th>type</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Sarabury</td>
      <td>2016-01-16 13:49:27</td>
      <td>38.35</td>
      <td>5403689035038</td>
      <td>46</td>
      <td>Urban</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Sarabury</td>
      <td>2016-07-23 07:42:44</td>
      <td>21.76</td>
      <td>7546681945283</td>
      <td>46</td>
      <td>Urban</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Sarabury</td>
      <td>2016-04-02 04:32:25</td>
      <td>38.03</td>
      <td>4932495851866</td>
      <td>46</td>
      <td>Urban</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Sarabury</td>
      <td>2016-06-23 05:03:41</td>
      <td>26.82</td>
      <td>6711035373406</td>
      <td>46</td>
      <td>Urban</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Sarabury</td>
      <td>2016-09-30 12:48:34</td>
      <td>30.30</td>
      <td>6388737278232</td>
      <td>46</td>
      <td>Urban</td>
    </tr>
  </tbody>
</table>
</div>




```python
urban_df = ride_data_complete[ride_data_complete["type"] == "Urban"]
urban_fare = urban_df.groupby(["city"]).mean()["fare"]
urban_ride = urban_df.groupby(["city"]).count()["ride_id"]
urban_drive = urban_df.groupby(["city"]).sum()["driver_count"]

urban_summary_df = pd.DataFrame({"Average Fare ($) Per City": urban_fare,
                                 "Total Number of Rides Per City": urban_ride,
                                 "Total Number of Drivers Per City": urban_drive})
urban_summary_df.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Average Fare ($) Per City</th>
      <th>Total Number of Drivers Per City</th>
      <th>Total Number of Rides Per City</th>
    </tr>
    <tr>
      <th>city</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Alvarezhaven</th>
      <td>23.928710</td>
      <td>651</td>
      <td>31</td>
    </tr>
    <tr>
      <th>Alyssaberg</th>
      <td>20.609615</td>
      <td>1742</td>
      <td>26</td>
    </tr>
    <tr>
      <th>Antoniomouth</th>
      <td>23.625000</td>
      <td>462</td>
      <td>22</td>
    </tr>
    <tr>
      <th>Aprilchester</th>
      <td>21.981579</td>
      <td>931</td>
      <td>19</td>
    </tr>
    <tr>
      <th>Arnoldview</th>
      <td>25.106452</td>
      <td>1271</td>
      <td>31</td>
    </tr>
  </tbody>
</table>
</div>




```python
rural_df = ride_data_complete[ ride_data_complete["type"] == "Rural"]
rural_fare = rural_df.groupby(["city"]).mean()["fare"]
rural_ride = rural_df.groupby(["city"]).count()["ride_id"]
rural_drive = rural_df.groupby(["city"]).sum()["driver_count"]

rural_summary_df = pd.DataFrame({"Average Fare ($) Per City": rural_fare,
                                 "Total Number of Rides Per City": rural_ride,
                                 "Total Number of Drivers Per City": rural_drive})
rural_summary_df.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Average Fare ($) Per City</th>
      <th>Total Number of Drivers Per City</th>
      <th>Total Number of Rides Per City</th>
    </tr>
    <tr>
      <th>city</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>East Leslie</th>
      <td>33.660909</td>
      <td>99</td>
      <td>11</td>
    </tr>
    <tr>
      <th>East Stephen</th>
      <td>39.053000</td>
      <td>60</td>
      <td>10</td>
    </tr>
    <tr>
      <th>East Troybury</th>
      <td>33.244286</td>
      <td>21</td>
      <td>7</td>
    </tr>
    <tr>
      <th>Erikport</th>
      <td>30.043750</td>
      <td>24</td>
      <td>8</td>
    </tr>
    <tr>
      <th>Hernandezshire</th>
      <td>32.002222</td>
      <td>90</td>
      <td>9</td>
    </tr>
  </tbody>
</table>
</div>




```python
suburban_df = ride_data_complete[ ride_data_complete["type"] == "Suburban"]
suburban_fare = suburban_df.groupby(["city"]).mean()["fare"]
suburban_ride = suburban_df.groupby(["city"]).count()["ride_id"]
suburban_drive = suburban_df.groupby(["city"]).sum()["driver_count"]

suburban_summary_df = pd.DataFrame({"Average Fare ($) Per City": suburban_fare,
                                    "Total Number of Rides Per City": suburban_ride,
                                    "Total Number of Drivers Per City": suburban_drive})
suburban_summary_df.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Average Fare ($) Per City</th>
      <th>Total Number of Drivers Per City</th>
      <th>Total Number of Rides Per City</th>
    </tr>
    <tr>
      <th>city</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Anitamouth</th>
      <td>37.315556</td>
      <td>144</td>
      <td>9</td>
    </tr>
    <tr>
      <th>Campbellport</th>
      <td>33.711333</td>
      <td>390</td>
      <td>15</td>
    </tr>
    <tr>
      <th>Carrollbury</th>
      <td>36.606000</td>
      <td>40</td>
      <td>10</td>
    </tr>
    <tr>
      <th>Clarkstad</th>
      <td>31.051667</td>
      <td>252</td>
      <td>12</td>
    </tr>
    <tr>
      <th>Conwaymouth</th>
      <td>34.591818</td>
      <td>198</td>
      <td>11</td>
    </tr>
  </tbody>
</table>
</div>




```python
c1="lightblue"
c2="gold" 
c3="coral"
edge = ["grey"]
plt.scatter(x=urban_ride, y=urban_fare, s=urban_drive*.25, c=c1, marker='o', edgecolors=edge, alpha=0.4, label='Urban') 
plt.scatter(x=rural_ride, y=rural_fare, s=rural_drive*.25, c=c2, marker='o', edgecolors=edge, alpha=0.4, label='Rural')
plt.scatter(x=suburban_ride, y=suburban_fare, s=suburban_drive*.25, c=c3, marker='o', edgecolors=edge, alpha=0.4, label='Suburban') 
plt.legend(fontsize="small", mode="Expanded", 
                  numpoints=1, scatterpoints=1, 
                  loc="best", title="City Types", 
                  labelspacing=0.5)
# Titles and grids
plt.title("Pyber Ride Sharing Data 2016")
plt.xlabel("Total Number of Rides (Per City)")
plt.ylabel("Average Fare ($)")
# BOTTOM LABEL
plt.figtext(1,0.8, "Note: Circle size correlates with driver count per city.", fontsize=9)
# Print Scatter Plot
plt.show()
```


![png](output_5_0.png)



```python
# # Create scatter plot
# x = suburban_ride 
# y = suburban_fare
# s = suburban_drive
# #ride_data_complete["driver_count"]
# # Q: How do I seperate by city types? Urban, Suburban, 
# # and Rural and how do I assign colors for each and include summary in my scatter plot? 
# color = "coral"
# plt.scatter(x=suburban_ride, y=suburban_fare, s=suburban_drive, c=color, alpha=0.25)
# # Titles and grids
# plt.title("Pyber Ride Sharing Data for Suburban Citites 2016")
# plt.xlabel("Total Number of Rides (Per City)")
# plt.ylabel("Average Fare ($)")
# # Print Scatter Plot
# plt.show()
```


```python
# Labels for the sections of our pie chart
labels = "Rural", "Suburban", "Urban"

# The values of each section of the pie chart
sum_rural= rural_fare.sum()
sum_urban= urban_fare.sum()
sum_sub= suburban_fare.sum()
sizes = [sum_rural, sum_sub, sum_urban]

# The colors of each section of the pie chart
colors = ["gold", "lightblue", "coral"]

# Tells matplotlib to seperate the "Python" section from the others
explode = (0.1, 0.1, 0, )

# Automatically finds the percentages of each part of the pie chart
plt.pie(sizes, explode=explode, labels=labels, colors=colors,
        autopct="%1.1f%%", shadow=True, startangle=140)

# Tells matplotlib that we want a pie chart with equal axes
plt.axis("equal")

#Title
plt.title("% of Total Fares by City Type")

# Prints our pie chart to the screen
plt.show()
```


![png](output_7_0.png)



```python
# Labels for the sections of our pie chart
labels = "Rural", "Suburban", "Urban"

# The values of each section of the pie chart
sum_rural= rural_ride.sum()
sum_urban= urban_ride.sum()
sum_sub= suburban_ride.sum()
sizes = [sum_rural, sum_sub, sum_urban]

# The colors of each section of the pie chart
colors = ["gold", "lightblue", "coral"]

# Tells matplotlib to seperate the "Python" section from the others
explode = (0.1, 0.1, 0,)

# Automatically finds the percentages of each part of the pie chart
plt.pie(sizes, explode=explode, labels=labels, colors=colors,
        autopct="%1.1f%%", shadow=True, startangle=140)

# Tells matplotlib that we want a pie chart with equal axes
plt.axis("equal")

#Title
plt.title("% of Total Rides by City Type")

# Prints our pie chart to the screen
plt.show()
```


![png](output_8_0.png)



```python
# Labels for the sections of our pie chart
labels = "Rural", "Suburban", "Urban"

# The values of each section of the pie chart
sum_rural= rural_drive.sum()
sum_urban= urban_drive.sum()
sum_sub= suburban_drive.sum()
sizes = [sum_rural, sum_sub, sum_urban]

# The colors of each section of the pie chart
colors = ["gold", "lightblue", "coral"]

# Tells matplotlib to seperate the "Python" section from the others
explode = (0.1, 0.1, 0,)

# Automatically finds the percentages of each part of the pie chart
plt.pie(sizes, explode=explode, labels=labels, colors=colors,
        autopct="%1.1f%%", shadow=True, startangle=140)

# Tells matplotlib that we want a pie chart with equal axes
plt.axis("equal")

#Title
plt.title("% of Total Drivers by City Type")

# Prints our pie chart to the screen
plt.show()
```


![png](output_9_0.png)

