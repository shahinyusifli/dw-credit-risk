### Architecture
Our data is stored in Amazon Redshift and comes from an S3 bucket. Initially, the data in the S3 bucket is imported from a source database, but it's limited to just 10 rows. Inside our data warehouse, we organize the data into three layers. The first layer is like a raw data dumping ground where we accept data without enforcing any specific types or constraints. Typically, all columns are treated as characters here.

Next, we move the data to the silver stage. In this stage, we apply business logic and perform type casting to structure and refine the data. Finally, the processed data is modeled into a multi-dimensional format and stored in the gold or presentation stage. This stage is where the data is optimized for analysis and reporting.
![alt text](https://github.com/shahinyusifli/dw-credit-risk/blob/main/document/architecture.png)

The presentation pipelines hold data transformations, like changing data types and selecting columns with descriptions. To make these transformations efficient, we use SQL within ELT pipelines. ELT stands for Extract, Load, Transform, where transformations are done directly within the data warehouse.

Inside our project, we've organized all the necessary tools for these transformations. This includes Stored Procedures, User-Defined Functions (UDFs), and SQL scripts. They are neatly placed within a scheduling application called Prefect, which acts as our project's scheduler. This setup helps streamline and optimize the execution of data transformations for speed and performance.
![alt text](https://github.com/shahinyusifli/dw-credit-risk/blob/main/document/pipelines_part_1.png)
![alt text](https://github.com/shahinyusifli/dw-credit-risk/blob/main/document/pipelines_part_2.png)

### Setup
First of all, all necessary libraries should be installed. For this purpose, you should run this command.

```bash
  $ pip install -r requirements.txt
```
Also, you should install the SQLite database which serves source for this project. You can download it from there
[SQLite](https://www.sqlite.org/draft/download.html). Also, an Amazon account will be needed for the S3 bucket and Redshift data warehouse. For creating a source data base, we should run this command but the loan.csv file should be located same folder path as setup_source_db.py. For running the script, we should use.
```bash
  $ python setup_source_db.py
```
### Data Extraction
Firstly, data extraction involves exporting the top 10 rows of data from a local transactional database to an S3 bucket as CSV objects. In the final step, these selected objects are copied to the bronze stage of the data warehouse. For these processes, we use ETL (Extract, Transform, Load) and ELT (Extract, Load, Transform) methods at different stages. ELT operations, in particular, are chosen to enhance the performance of data loading.

To automate these tasks, we've deployed two pipelines: "to-s3-flow/csv_to_s3_bucket" for exporting to the S3 bucket, and "to-bronze-flow/to_bronze" for copying to the bronze stage of the data warehouse. These pipelines are set to initiate data loading on a daily basis, limited to 10 rows based on unique IDs between the source and destination bronze stages.

For running metioned pipeles, you should login [Prefect Cloud](https://www.prefect.io/cloud) and you should run this script for creating connection:
```bash
  $ prefect cloud login
```
After creating a connection between local and cloud environments. You can use a script or UI for running pipelines. And you should run to-s3-flow/csv_to_s3_bucket and to-bronze-flow/to_bronze respectively. They are scheduled for each day but they can be triggered manually.
Type of columns are divided into 3 main types Integer, Char, and Real(Decimal). IDs and categorical values are represented in Integer but numeric values are represented with Real(Decimal) data type. Finally, some categorical and descriptive information are selected as Char.
SQLite is used as a data source because most of the time relational databases are sources of predictive and descriptive applications and SQLLite meets minimal requirements of this.
### Data Transformation
All data transformation processes occur in the Silver stage of the data warehouse. SQL is used for processing which increases the speed and performance of transformation in environments in which storage and processing are separated. For triggering transformations, we can run to-silver-flow/to_silver from UI or with the BASH command. 

### Data Loading
Amazon Redshift is selected for the data warehouse. For modeling data, the Kimball data model is selected with a star schema. For improving the performance of data transdormation and transformations 3 stage architecture is selected.  

Data loading cover operations for data loading to dimensions and fact table. Listed pipelines are used for this purpose:
- to-dim-calendar-flow/to_dim_calendar
- to-dim-grade-flow/to_dim_grade
- to-dim-member-flow/to_dim_member
- to-dim-ownership-flow/to_dim_ownership
- to-dim-payment-flow/to_dim_payment
- to-dim-status-flow/to_dim_status
- to-fct-credit-flow/to_fct_credit
- to-silver-flow/to_silver
