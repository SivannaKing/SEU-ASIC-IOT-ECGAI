	?fh<R@?fh<R@!?fh<R@	3?ҸY_??3?ҸY_??!3?ҸY_??"{
=type.googleapis.com/tensorflow.profiler.PerGenericStepDetails:?fh<R@?v????A%t??YR@Y??ID???rEagerKernelExecute 0*	6^?I?L@2l
5Iterator::Model::ParallelMapV2::Zip[1]::ForeverRepeat?r?蜟??!?_T[A??@)??#?????1?,?T??:@:Preprocessing2U
Iterator::Model::ParallelMapV2?W?\T??!٪S?AM7@)?W?\T??1٪S?AM7@:Preprocessing2F
Iterator::Model?S?*???!??s?B)D@)v?1<???1RʓD1@:Preprocessing2v
?Iterator::Model::ParallelMapV2::Zip[0]::FlatMap[0]::Concatenate6?????!o?|???2@)4????w?1??3Ed$@:Preprocessing2?
OIterator::Model::ParallelMapV2::Zip[0]::FlatMap[0]::Concatenate[0]::TensorSlice9+?&?|t?![?ō'x!@)9+?&?|t?1[?ō'x!@:Preprocessing2Z
#Iterator::Model::ParallelMapV2::ZipV}??b??!kE???M@)??Y?h9p?1???4٪@:Preprocessing2x
AIterator::Model::ParallelMapV2::Zip[1]::ForeverRepeat::FromTensor??;??~f?!??@.@)??;??~f?1??@.@:Preprocessing2f
/Iterator::Model::ParallelMapV2::Zip[0]::FlatMapzZ?????!kn?v? 5@)????T?1ᗭh??@:Preprocessing:?
]Enqueuing data: you may want to combine small input data chunks into fewer but larger chunks.
?Data preprocessing: you may increase num_parallel_calls in <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#map" target="_blank">Dataset map()</a> or preprocess the data OFFLINE.
?Reading data from files in advance: you may tune parameters in the following tf.data API (<a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#prefetch" target="_blank">prefetch size</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#interleave" target="_blank">interleave cycle_length</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/TFRecordDataset#class_tfrecorddataset" target="_blank">reader buffer_size</a>)
?Reading data from files on demand: you should read data IN ADVANCE using the following tf.data API (<a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#prefetch" target="_blank">prefetch</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#interleave" target="_blank">interleave</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/TFRecordDataset#class_tfrecorddataset" target="_blank">reader buffer</a>)
?Other data reading or processing: you may consider using the <a href="https://www.tensorflow.org/programmers_guide/datasets" target="_blank">tf.data API</a> (if you are not using it now)?
:type.googleapis.com/tensorflow.profiler.BottleneckAnalysis?
device?Your program is NOT input-bound because only 0.1% of the total step time sampled is waiting for input. Therefore, you should focus on reducing other time.no*no93?ҸY_??I\ˑ)??X@Zno#You may skip the rest of this page.B?
@type.googleapis.com/tensorflow.profiler.GenericStepTimeBreakdown?
	?v?????v????!?v????      ??!       "      ??!       *      ??!       2	%t??YR@%t??YR@!%t??YR@:      ??!       B      ??!       J	??ID?????ID???!??ID???R      ??!       Z	??ID?????ID???!??ID???b      ??!       JCPU_ONLYY3?ҸY_??b q\ˑ)??X@