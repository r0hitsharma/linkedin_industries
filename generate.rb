require 'yaml'
require 'json'
require 'pp'

# Some input/output file paths
infile = File.join(File.dirname(__FILE__), 'linkedin_industries.csv')
outfile_basename = 'linkedin_industries'

# Grab input from CSV and covert to native Ruby objects. We use CSV here because
# it's the most direct text format we can get by copying from LinkedIn's own
# docs.
industries = File.open(infile).read
  .strip.split(/\r?\n/)
  .inject [] do |memo, line|
  # Extract comma-separated components
  cols = line.split(',').map{ |c| c.strip }

  # Skip poorly-formatted lines
  next memo unless cols.size == 3

  # Add industry details
  memo << {
    'code' => cols[0].to_i,
    'groups' => cols[1].split(/\s+/),
    'description' => cols[2],
  }

  # Next line
  memo
end

# Dump to various formats
{
  'js' => JSON.pretty_generate(industries),
  'yaml' => industries.to_yaml,
  'rb' => industries.pretty_inspect
}.each do |extension, text|
  filename = "#{outfile_basename}.#{extension}"
  puts "generating #{filename}"  
  File.open(filename, 'w') { |f| f.write(text) }
end