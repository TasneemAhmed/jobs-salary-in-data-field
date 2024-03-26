import pyspark
from pyspark.sql import SparkSession
from pyspark.conf import SparkConf
from pyspark.context import SparkContext

import argparse


def main(params):
    src_file = params.src_data_path
    temp_bucket = params.temp_bucket_path
    dest_table = params.output_path
   
   

    spark = SparkSession.builder \
        .appName('jobs-analysis-dataproc') \
        .getOrCreate()


    # Use the Cloud Storage bucket for temporary BigQuery export data used
    # by the connector.
    #this temp bucket in GC Storage created when create cluster in DataProc
    spark.conf.set("temporaryGcsBucket",temp_bucket)

    # 1. Read data as PySpark Dataframe from GCS Bucket
    # - Configure schema


    from pyspark.sql import types

    # set a schema
    jobs_df_schema = types.StructType([ 
        types.StructField('_c0', types.IntegerType(), True), 
        types.StructField('work_year', types.DateType(), True), 
        types.StructField('experience_level', types.StringType(), True), 
        types.StructField('employment_type', types.StringType(), True), 
        types.StructField('job_title', types.StringType(), True), 
        types.StructField('salary', types.IntegerType(), True),
        types.StructField('salary_currency', types.StringType(), True),
        types.StructField('salary_in_usd', types.IntegerType(), True),
        types.StructField('employee_residence', types.StringType(), True),
        types.StructField('work_setting', types.StringType(), True),
        types.StructField('company_location', types.StringType(), True),
        types.StructField('company_size', types.StringType(), True),
        types.StructField('job_category', types.StringType(), True)
    ]) 



    # read data with new schema

    jobs_df = spark.read.option("header","true")\
            .schema(jobs_df_schema)\
            .csv(src_file)

    # # 2. Transform Jobs data
    # - Drop unneeded column "_c0"
    # - company_size column replace S->Small  , M->Medium, L->Large

    # Drop "_c0" clumn
    jobs_df = jobs_df.drop("_c0")

    from pyspark.sql.functions import when

    # company_size column replace S->Small  , M->Medium, L->Large
    transformed_jobs_df = jobs_df.withColumn("company_size", when(jobs_df.company_size == "S","Small") \
        .when(jobs_df.company_size == "M","Medium") \
                .when(jobs_df.company_size == "L" , "Large"))


    # # 3. Load Transformed data into Google BigQuery table
    # - Partition data by work_year column

    transformed_jobs_df.write.format('bigquery') \
    .option("temporaryGcsBucket",temp_bucket)\
        .option('table', dest_table) \
            .mode("overwrite")\
            .save()



if __name__ == "__main__":
    # Create the parser
    parser = argparse.ArgumentParser()
    # Add an argument:
        #src_data_path
        #temp_bucket_path
        #output_path

    parser.add_argument('--src_data_path', required=True, help="The path where source file located")
    parser.add_argument('--temp_bucket_path', required=True, help="GCS path source where temp bucket located created after create DataProc cluster")
    parser.add_argument('--output_path', required=True, help="dataset.table in GC BigQuery where transformed data will located ")


    # Parse the argument
    args = parser.parse_args()

    main(args)


"""
1. created DataProc cluster, & dataset using Terraform(IAC)
2. cd [the path where python script located]
3. gcloud dataproc jobs submit pyspark jobs_pyspark_analysis.py --cluster=dataproc-pyspark-cluster --region=us-central1 --jars=gs://spark-lib/bigquery/spark-bigquery-latest_2.12.jar
--project=jobs-salaries-in-data -- --src_data_path=gs://jobs-salaries-in-data-bucket/jobs_salaries.csv --temp_bucket_path=jobs-salaries-in-data-bucket/google-cloud-dataproc-metainfo/de38da4b-7209-4bd8-9060-1231928a07fa
--output_path=jobs_salaries_in_data_dataset.jobs_cleaned_partitioned_data
"""