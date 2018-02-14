

```python
# Dependencies
import os
import csv
import pandas as pd
```


```python
# Create a csv path for both files and read
schools = os.path.join("raw_data/schools_complete.csv")
schools_df = pd.read_csv(schools, encoding = "ISO-8859-1")
# Total Schools
schools_df["Total Schools"] = schools_df["name"].sum()
```


```python
# Create a csv path and read
students = os.path.join("raw_data/students_complete.csv")
students_df = pd.read_csv(students, encoding = "ISO-8859-1")
# Total Students
students_df["Total Students"] = students_df["name"].sum()
students_df.head()
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
      <th>Student ID</th>
      <th>name</th>
      <th>gender</th>
      <th>grade</th>
      <th>school</th>
      <th>reading_score</th>
      <th>math_score</th>
      <th>Total Students</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>Paul Bradley</td>
      <td>M</td>
      <td>9th</td>
      <td>Huang High School</td>
      <td>66</td>
      <td>79</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>Victor Smith</td>
      <td>M</td>
      <td>12th</td>
      <td>Huang High School</td>
      <td>94</td>
      <td>61</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2</td>
      <td>Kevin Rodriguez</td>
      <td>M</td>
      <td>12th</td>
      <td>Huang High School</td>
      <td>90</td>
      <td>60</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>3</th>
      <td>3</td>
      <td>Dr. Richard Scott</td>
      <td>M</td>
      <td>12th</td>
      <td>Huang High School</td>
      <td>67</td>
      <td>58</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>4</th>
      <td>4</td>
      <td>Bonnie Ray</td>
      <td>F</td>
      <td>9th</td>
      <td>Huang High School</td>
      <td>97</td>
      <td>84</td>
      <td>39170</td>
    </tr>
  </tbody>
</table>
</div>




```python
Combined_df = pd.merge(schools_df, students_df, how="outer", on="name")
Combined_df.head()
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
      <th>School ID</th>
      <th>name</th>
      <th>type</th>
      <th>size</th>
      <th>budget</th>
      <th>Total Schools</th>
      <th>Student ID</th>
      <th>gender</th>
      <th>grade</th>
      <th>school</th>
      <th>reading_score</th>
      <th>math_score</th>
      <th>Total Students</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0.0</td>
      <td>Huang High School</td>
      <td>District</td>
      <td>2917.0</td>
      <td>1910635.0</td>
      <td>15.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1.0</td>
      <td>Figueroa High School</td>
      <td>District</td>
      <td>2949.0</td>
      <td>1884411.0</td>
      <td>15.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2.0</td>
      <td>Shelton High School</td>
      <td>Charter</td>
      <td>1761.0</td>
      <td>1056600.0</td>
      <td>15.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>3</th>
      <td>3.0</td>
      <td>Hernandez High School</td>
      <td>District</td>
      <td>4635.0</td>
      <td>3022020.0</td>
      <td>15.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>4</th>
      <td>4.0</td>
      <td>Griffin High School</td>
      <td>Charter</td>
      <td>1468.0</td>
      <td>917500.0</td>
      <td>15.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Total Budget
Combined_df["Total Budget"] = Combined_df["budget"].sum()
# Average Math Score
Combined_df["Average Math Score"] = Combined_df["math_score"].mean()
# Average Reading Score
Combined_df["Average Reading Score"] = Combined_df["reading_score"].mean()
# % Passing Math
Combined_df["Passing math"] = Combined_df["math_score"] > 69
Combined_df["Number Passing Math"] = Combined_df["Passing math"].count()
Combined_df["Percent Passing Math"] = ((Combined_df["Number Passing Math"])/(Combined_df["Total Students"]))*100
# % Passing Reading
Combined_df["Passing reading"] = Combined_df["reading_score"] > 69
Combined_df["Number Passing Reading"] = Combined_df["Passing reading"].count() 
Combined_df["Percent Passing Reading"] = ((Combined_df["Number Passing Reading"])/(Combined_df["Total Students"]))*100
# Overall Passing Rate (Average of the above two)
Combined_df["Overall Passing Rate"] = ((Combined_df["Passing math"]) + (Combined_df["Passing reading"]))/2

```

    /Users/jeanetteilongo/anaconda3/lib/python3.6/site-packages/pandas/core/computation/expressions.py:183: UserWarning: evaluating in Python space because the '+' operator is not supported by numexpr for the bool dtype, use '|' instead
      unsupported[op_str]))



```python
# School Name
# School Type
# Total Students
# Total School Budget

# Per Student Budget
# Average Math Score
# Average Reading Score
# % Passing Math
# % Passing Reading
# Overall Passing Rate (Average of the above two)

```
