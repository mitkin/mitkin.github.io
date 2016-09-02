Conditional selection of NetCDF indices (based on time)
=======================================================

One little thing that I use fairly often but fail to remember is how to make a conditional selection of the steps/indices when retrieving data from a NetCDF file.

A typical reason for selective pulling of the data is to avoid filling memory with the entire dataset when in fact I need only tiny bit of it.

Here are the steps I am doing it at the moment:

* Retrieve time information from the array (the time vector is normally much smaller than 3D data I am working with).
* Perform selection of the timestamps based on some condition
* Use numpy.flatnonzero_ to return an array mask which is then passed further to the file handler.


::

    time_array = file.variables['time'][:]
    data = file.variables['data'][np.flatnonzero(time_array == '2007)]


However this would be too easy. The time information often comes in the format similar to the Unix epoch format, with some offset. Typical format would be 'seconds since January 1st, 1980'. Few additional steps are necessary to make sure we can apply selection to the data array and maintain the code readable. In my case those are:

* Apply offset to the time array to convert it to the standard Unix epoch timestamps
* Convert the array to the list of datetime objects
* Finally apply your condition

::

    # apply offset to convert the timestamp to 'seconds since 1st of January, 1970'
    epoch_offset = 252460800
    time_array_with_offset = time_array + epoch_offset

    # convert the array to the list of datetime objects
    convert_to_datetime = lambda t: datetime.datetime.fromtimestamp(t)
    datetime_list = map(convert_to_datetime, time_array)

    # let's go a bit further an create a list with years only, omit other time information
    years_list = map(lambda t: t.year, datetime_list)

At this point we can finally apply selection by years:

::

    data = file.variables['data'][np.flatnonzero(years_list == '2007')



.. author:: default
.. categories:: Programming, Jots
.. tags:: netcdf, python, numpy
.. comments::

.. _numpy.flatnonzero: http://docs.scipy.org/doc/numpy/reference/generated/numpy.flatnonzero.html
