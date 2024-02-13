if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):

    data = data[data['passenger_count'] != 0]
    data = data[data['trip_distance'] != 0]
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date

    reg = '(?<=[a-z])(?=[A-Z])'
    print('Columns to be renamed to snake case: {}'.format(data.filter(regex=(reg)).columns))

    data.columns = (data.columns
                .str.replace(reg, '_', regex=True)
                .str.lower()
             )

    print('Existing values of VendorID are {}'.format(list(data['vendor_id'].unique())))

    print('The shape of the filtered dataset is: {}'.format(data.shape))

    return data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
    assert 'vendor_id' in output, 'No vendor_id column'
    assert (output['passenger_count'] <= 0).sum() == 0, 'passenger_count smaller than 0'
    assert len(output[output['trip_distance']<=0])==0, 'trip_distance smaller than 0'

