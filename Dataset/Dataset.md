# Dataset
## MIT-BIH Arrhythmia Database
The database was the first generally available set of standard test material for evaluation of arrhythmia detectors, and has been used for that purpose as well as for basic research into cardiac dynamics at more than 500 sites worldwide. 

The MIT-BIH Arrhythmia Database contains 48 half-hour excerpts of two-channel ambulatory ECG recordings, obtained from 47 subjects studied by the BIH Arrhythmia Laboratory between 1975 and 1979. Twenty-three recordings were chosen at random from a set of 4000 24-hour ambulatory ECG recordings collected from a mixed population of inpatients (about 60%) and outpatients (about 40%) at Boston's Beth Israel Hospital; the remaining 25 recordings were selected from the same set to include less common but clinically significant arrhythmias that would not be well-represented in a small random sample.

The recordings were digitized at 360 samples per second per channel with 11-bit resolution over a 10 mV range. Two or more cardiologists independently annotated each record; disagreements were resolved to obtain the computer-readable reference annotations for each beat (approximately 110,000 annotations in all) included with the database.

Access the files
* MIT-BIH Arrhythmia Database is available on [physionet](https://www.physionet.org/content/mitdb/1.0.0/).
* [Download the ZIP file](https://www.physionet.org/static/published-projects/mitdb/mit-bih-arrhythmia-database-1.0.0.zip) (73.5 MB)
* Access the files using the Google Cloud Storage Browser [here](https://console.cloud.google.com/storage/browser/mitdb-1.0.0.physionet.org/). Login with a Google account is required.
* Access the data using the Google Cloud command line tools (please refer to the [gsutil](https://cloud.google.com/storage/docs/gsutil_install) documentation for guidance): `gsutil -m -u YOUR_PROJECT_ID cp -r gs://mitdb-1.0.0.physionet.org DESTINATION`
* Download the files using your terminal: `wget -r -N -c -np https://physionet.org/files/mitdb/1.0.0/`




## 17 Classes ECG signals (1000 fragments)
Contributor : Paweł Pławiak

The created database with ECG signals is described below.
1. The ECG signals were from 45 patients: 19 female (age:23-89) and 26 male (age:32-89).
2. The ECG signals contained 17 classes: normal sinus rhythm, pacemaker rhythm, and 15 types of cardiac dysfunctions (for each of which at least 10 signal fragments were collected).
3. All ECG signals were recorded at a sampling frequency of **360 [Hz]** and a gain of 200 [adu / mV].
4. For the analysis, **1000, 10-second (3600 samples)** fragments of the ECG signal (not overlapping) were randomly selected.
5. Only signals derived from one lead, the MLII, were used.
6. Data are in mat format (Matlab).

Access the files
* 17 Classes ECG signals (1000 fragments) based on MIT-BIH is available on [mendeley](https://data.mendeley.com/datasets/7dybx7wyfn/3).

Related Links 
* [Article](http://dx.doi.org/10.1016/j.eswa.2017.09.022)

TODO 描述5分类数据集