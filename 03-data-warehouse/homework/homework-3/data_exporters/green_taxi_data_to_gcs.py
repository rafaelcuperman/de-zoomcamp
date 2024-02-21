from mage_ai.settings.repo import get_repo_path
from mage_ai.io.config import ConfigFileLoader
from mage_ai.io.google_cloud_storage import GoogleCloudStorage
from pandas import DataFrame
from os import path

import pyarrow as pa
import pyarrow.parquet as pq
import os

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter


# This should work, but there is a problem with dates and parquet files, so we must use the option below instead
# @data_exporter
# def export_data_to_google_cloud_storage(df: DataFrame, **kwargs) -> None:
#     """
#     Template for exporting data to a Google Cloud Storage bucket.
#     Specify your configuration settings in 'io_config.yaml'.

#     Docs: https://docs.mage.ai/design/data-loading#googlecloudstorage
#     """
#     config_path = path.join(get_repo_path(), 'io_config.yaml')
#     config_profile = 'default'

#     bucket_name = 'de-zoomcamp-rc-homework-3'
#     object_key = 'green-taxi-data-2022.parquet'


#     GoogleCloudStorage.with_config(ConfigFileLoader(config_path, config_profile)).export(
#         df,
#         bucket_name,
#         object_key,
#     )


# Option that works with dates and parquet files
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = "/home/src/creds.json"
bucket_name = 'de-zoomcamp-rc-homework-3'
object_key = 'green-taxi-data-2022.parquet'
where = f'{bucket_name}/{object_key}'  

@data_exporter
def export_data(data, *args, **kwargs) -> None:
    table = pa.Table.from_pandas(data, preserve_index = False)
    gcs = pa.fs.GcsFileSystem()

    pq.write_table(table, where, coerce_timestamps='us', filesystem=gcs)