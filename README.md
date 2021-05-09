# Information-Architecture-Final

There are several broad steps used in the process of Setting up this Pipeline. We will be going through them generally to ensure that you know what to do and when and how to set this all up in your environment.

IT should be noted that there is a great deal of reference material in the provided documents.

# Overview:There needs to be an Overview Section describing what the project is and the goals.

# Content: 

There are many files provided in this Github Repo. This section will be providing an overview of each file.

Raw Datasets: Contains csv and Json files used in the process of implementing this pipeline. 

- C_User_elham_Desktop_New_value file contians unstructured data.
- Median Income 2016.csv, Median Income, 2017.csv, Median Income 2018.csv and Median Income 2019.csv all contain Median Income by zip code.
- 5_Year_Giving.csv contains data on donations for the last five years at Yeshiva University.

Scripts: Contains Python and SQL code used in the process of implementing this pipeline. 

- Python - Contains three python scripts. These scripts need to be modified before use(Details provided in the Set-up and Daily Updates Section of this Read Me.
- SQL - These scripts contain the details needed to create your database and all procedure.

Documentation: Contains A high-Level project plan, Business Matrix, conceptual data model, Logical data model, Physical Data Model, Data Dictionary, and Basic use cases.  

- High-Level project plan - Contains an excel table with detailed descriptions of our weekly goals. As well as a waterfall project overview populated from that excel sheet.

# Outline: there need to be an outline of all the broad steps taken. basically a recap of our timeline

# Set Up

Step 1: Set up an AWS account. Please reference the "IA Donors DW Architecture Final.png" and IA donors_dw Network Diagram V3.pdf documents provided for an    overview of the AWS services that will be used. Note: This documentation assumes a certain degree of familiarity with AWS. We will not be detailing the setup of an amazon web service environment here.

Step 2: Create an S3 Bucket. 

Step 3: Run the two provided SQL scripts in MySQL workbench. Run "createdb_final_V3.sql" first and then "procedures_final_V3.sql".

Step 4: Open Jupyter Notebook and run the two python scripts "Onboard Historical Data Final.ipynb" and "Onboarding Historical Stats Final.ipynb". Important Note: That the scripts can not be run as-is. You will need to make small revisions for full functionality in your environment. The fields that need to be changed are:
        
     To connect to mysql you must change the following information in both scripts. 
    -host_name 
    -u_name
    -pwd
        
     To connect to your Jupyter Notebook to AWS you must change the following information in "Onboard Historical Data Final.ipynb" script. 
    -s3pathName 
    -FileNameFullPath
    -filenames3
        
     To connect to your Jupyter Notebook to AWS you must change the following information in "Onboarding Historical Stats Final.ipynb" script. 
    -s3pathName 
    -s3pathName1
    -FileNameFullPath
    -FileNameFullPath1
    -filenames3 
    -filenames3_1
        
The basic setup is all done. You should not run into serious issues. If you do it may be one of the following issues.

Step 5: Trouble Shooting 

-Please double-check Step 4 to ensure that you made the appropriate edits to the Python scripts before running them in Jupyter Notebook. 

-Please make sure that the S3 bucket you set up is Public.

---


# Daily Updates 

Updating the S3 Bucket with new donation data.

Step 1: Run the "Daily Update Final.ipynb" python script in Jupyter Notebook. Important Note: That the scripts can not be run as-is. You will need to make small revisions for full functionality in your environment. The fields that need to be changed are:
        
     To connect to mysql you must change the following information in both scripts. 
    -host_name 
    -u_name
    -pwd
        
     To connect to your Jupyter Notebook to AWS you must change the following information in "Onboard Historical Data Final.ipynb" script. 
    -s3pathName 
    -FileNameFullPath
    -filenames3
        

Step 2: Trouble Shooting 

-Make sure that "path" is pointed at the right file location on your computer. For example: 'C:\Users\PC\Desktop\Donors_DW_Daily'

-Make Sure your daily update data is structured the same as the data currently hosted in the S3 bucket you are loading to. For example: check the columns, headers, and make sure all data types are the same as the S3 bucket.


# Visualizing Insights With Tableau
        
