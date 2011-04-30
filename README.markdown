# Hotrod Infinispan Ruby Client
This is a Hot Rod ruby client for JBoss Infinispan Data Grid Solution.

It is in development and only GET and PUT opeations are working with some limitations:
* Just default cache
* I haven't test it that much
* More to come :)

## How to use it?
Look at spec/remotecache_spec.rb :P

## Note:
1) First start a HotRod Server module of Infinispan

    ./startServer.sh -r hotrod

# Features to add
* Support cache names (needs to be decided by Infinispan Team) - Code ready need more test
* Add ping operation before any call
* Validate response headers
* Add Remaining operations
** removeWithVersion
** putIfAbsentputAll
** remove/if
** replace/if
** containsKey
** getWithVersion
** removeWithVersion
** statistic
** put/getBulk
* Support for  lifespanSeconds and maxIdleTimeSeconds
* Batch support
* Obtaing Statistics (operation)
* Support for Intelligence Clients and Topologies and Listener
* Configuration files support
* Transaction support
* Support for Apache Avro Marshaller 