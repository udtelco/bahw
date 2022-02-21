require 'sinatra'

def underCamelize(s)
 idx = 0
 s.downcase.split("-").each{|a| a[0]=a[0].upcase if  idx>0; idx=idx+1}.join
end

get '/' do
 underCamelize(params['transform'])
end

