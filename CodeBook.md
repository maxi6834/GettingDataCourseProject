==================================================================
Human Activity Recognition Using Smartphones Dataset - Tidy version
Version 1.0
==================================================================
MaxS
==================================================================

This dataset is based on (Human Activity Recognition Using Smartphones Dataset)[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones]. The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

The dataset consists of two tables:
* **tidy_ds_1.csv**. Each record provides the following information:
 * object id - unique id of the record
 * subject - ID of the person
 * activity - name of the activity that the person was performing
 * 66 values representing subset of the source dataset representing means and std devs of the measurements
 
* **tidy_ds_2.csv**. This is the summarized version of tidy_ds_1.csv. It is summarized for each subject and activity and provides the following information:
 * subject - ID of the person
 * activity - name of the activity
 * 66 values representing mean values for the records in tidy_ds_1.csv that correspond to the given subject and activity


For more information please refer to (this)[https://class.coursera.org/getdata-034/] Coursera course and to the (original source)[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones] of the data.