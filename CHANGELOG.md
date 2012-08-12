## Wukong v2.0.0

#### Important changes

* Passing options to streamers is now deprecated. Use `Settings` instead. 

* Streamer by default has a periodic monitor that logs (to STDERR by default) every 10_000 lines or 30 seconds

* Examples cleaned up, should all run

#### Simplified syntax

* you can now pass Script.new an *instance* of Streamer to use as mapper or reducer
* Adding an experimental sugar:

```ruby
    #!/usr/bin/env ruby
    require 'wukong/script'

    LineStreamer.map do |line|
      emit line.reverse
    end.run
```

  Note that you can now tweet a wukong script.

* It's now recommended that at the top of a wukong script you say `require 'wukong/script'`
  Among other benefits, this lets you refer to wukong streamers without prefix.  

## Wukong v1.5.4

* EMR support now works very well

## Wukong v1.5.3

* A couple of bugfixes. Sorry about that.
* Documentation fixes

## Wukong v1.5.0

#### Elastic Map-Reduce

Use --run=emr to launch a job onto the Amazon Elastic MapReduce cloud.

* copies the script to s3, as foo-mapper.rb and foo-reducer.rb (removing the need for the --map flag)
* copies the wukong libs up as a .tar/bz2, and extracts it into the cwd
* combines settings from commandline and yaml config, etc to configure and launch job

It's still **way** shaky and I don't think anything but the sample app will run.  That sample app runs, tho.

#### Greatly simplified script launching.

Incompatible changes to option handling and script launching:
* Script doesn't use extra_options any more. You should relocate them to the initializer or to configliere.
* there is no more default_mapper or default_reducer

## Wukong v.14.12 2010-08-31

* Improvements to the pig conversion methods
* `hdp-rm` respects the -skipTrash method


## Wukong v1.4.11 2010-07-30

* added the `max_(maps|reduces)_per_(node|cluster)` jobconfs.
* added jobconfs for io_job_mb and friends.
* added a loadable module to convert output data to pig bags and tuples
* pulled in several methods from active_support, incl. Enumerable#sum
* Scripts to find percentile rank of elements in a dataset
* We are starting to move wukong to a model where streaming is from a generic
  source into a generic sink. Several stores have been landed in the code, but
  many are in a half- or un-baked state. Please ignore this for the moment.

## Wukong v1.4.8 2010-06-05

* made scripts inject a helpful job name using mapred.job.name
* Hash.compact_blank! and HashLike.compact_blank! -- eliminate all key-values whoes value is blank?

## Wukong v1.4.8 2010-05-17

* Bug in passing commandline args down to map and reduce child processes

## Wukong v1.4.7 2010-03-05

Lots more examples:
* examples/stats/avg_value_frequency.rb does an Average Value Frequency histogram
* examples/server_logs has a quite useful apache log file parser
* Made the base streamer use each_record, opening the door for alternative record injection (eg Datamapper!)
* wukong/streamer/counting_reducer.rb is an um reducer and it counts things.

## Wukong v1.4.6 2010-01-26

* A HELLA AWESOME working example from retail web analytics by @lenbust

## Wukong v1.4.5 2010-01-18

* In `--run=local` mode, you can use '-' alone as a filename to indicate STDIN / STDOUT as input/output respectively.
* Minor tweaks to contrib/jeans

## Wukong v1.4.4 2010-01-15

* Moved settings management & command line handling over to [Configliere](http://github.com/mrflip/configliere) (
* Added [example script and notes](http://github.com/fredrikmollerstrand/hackblag/blob/master/wukong/notes.markdown) from Fredrik Möllerstrand (@lenbust)
