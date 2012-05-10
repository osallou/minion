#!/usr/bin/env ruby

#
# This example illustrates the use of the :when
# parameter to allow/disallow subscription to the
# queue
#

$:.unshift File.dirname(__FILE__) + '/../lib'
require 'rubygems'
require 'mb-minion'

include Minion

error do |exception,queue,message,headers|
	puts "got an error processing queue #{queue}"
	puts exception.message
	puts exception.backtrace
end

logger do |msg|
	puts "--> #{msg}"
end

$listen = true

job "do.once", :when => lambda { $listen } do |args|
	puts "Do this one action - then unsubscribe..."
	$listen = false
end

enqueue("do.once",[])
enqueue("do.once",[])

