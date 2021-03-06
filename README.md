# Information-Architecture-Final

There are several broad steps used in the process of Setting up this Pipeline. We will be going through them generally to ensure that you know what to do and when and how to set this all up in your environment.

IT should be noted that there is a great deal of reference material in the provided documents.

# Overview

This project and all tools in this GitHub repo were designed and built for use with Yeshiva Universities Donation Data. 

This project aims to allow users to gain insights from the donation data that would previously be impossible. This is done by using the Donation data's zip code section and comparing it to additional datasets containing Income and home price by zip code.

It should be noted that this pipeline is designed for reproducibility purposes. As such any new data released can be uploaded directly to the pipeline.  This allows users to easily incorporate new data into the existing analysis.

When fully set up the user can perform a vast array of analytics. Gaining insights on donors using the area they live for insights.

Note: All relevant identifying data has been removed from the donation data sets.

![](Documentation/Project%20Management/Conceptual%20Data%20Models%20(1).png)


# Content 

There are many files provided in this Github Repo. This section will be providing an overview of each file.

Raw Datasets: Contains csv and Json files used in the process of implementing this pipeline. 

- New_value.json file contians unstructured data.
- Median Income 2016.csv, Median Income, 2017.csv, Median Income 2018.csv and Median Income 2019.csv all contain Median Income by zip code.
- 5_Year_Giving.csv contains data on donations for the last five years at Yeshiva University.

Scripts: Contains Python and SQL code used in the process of implementing this pipeline. 

- Python - Contains three python scripts. These scripts need to be modified before use(Details provided in the Set-up and Daily Updates Section of this Read Me.
- SQL - These scripts contain the details needed to create your database and all procedure.

Documentation: Contains Project managment, Databases, ETL, Images and Analytics(Tableau).  

-Analytics (Tableau) - Contains dashboards with analytics of our datasets.

- Business Use Case - Contains a PDF with detailed use cases of this project.

- ETL - Contains a PDF with all ETL instructions.

- Images - Contains a PDF with the network diagrams and PNG of the Data warhouse architecture.

- Project Management - Contains A high-Level project plan, Business Matrix, conceptual data model, Logical data model, Physical Data Model, Data Dictionary, Physical layout and Basic use cases. 

- High-Level project plan - Contains an excel table with detailed descriptions of our weekly goals. As well as a waterfall project overview populated from that excel sheet.

# Outline of project Goals: 

Increment 1 - Decided on Data sets and a general overview of the project objective.

Increment 2 - Began research on data sets, ETL process, and Database Architecture.

Increment 3 - Began building the data warehouse. Started writing scripts for the Database. Writing Scripts in python to push the data to AWS. Worked on retrieving and organizing unstructured data.

Increment 4 - Continued building the data warehouse. Continued writing scripts for the database. Continued writing Scripts in python to push the data to AWS. Continued working on retrieving and organizing unstructured data.

Increment 5 - Trouble shooted python and SQL. Made changes to the schema of the database. 

Increment 6 - Made final adjustments to scripts.

Increment 7 - Began organizing all documentation.

Increment 8 - Created the presentation.

Increment 9 - Rehearsed the presentation for the Final.


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

The Tableau Dashboard is located in the documentation folder. It contains valuable insights we gleaned using our dataset. To access it you must download and install Tableau on your computer. The file can be directly downloaded from Github. This allows anyone to perform their own statistical analysis with this data set or create their own dashboards.
        
