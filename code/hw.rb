require 'sinatra'

def underCamelize(input)
 # we won't be raise TypeError, 'underCamelize expects a String' unless s.kind_of?(String)
 s = input.to_s
 s="" if s.nil?
 idx = 0
 s.downcase.split("-").each{|a| a[0]=a[0].upcase if  idx>0; idx=idx+1}.join
end

get '/' do
 underCamelize(params['transform'])
end

