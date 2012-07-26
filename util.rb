require 'yaml'

# CSV format: code, [group_1 group_2 ...], description
def csv2array(text)

end

# Grab input from CSV. We use CSV here because it's the most direct text format
# we can get by copying from LinkedIn's own docs.
csv_path = ARGV[1] || File.join(File.dirname(__FILE__), 'linkedin_industries.csv')
csv = File.open(csv_path).read

# Convert to a native Ruby format
industries = csv.strip.inject([]) do |memo, line|
  # Extract comma-separated components
  cols = line.split(',').map{ |c| c.strip }

  # Skip poorly-formatted lines
  next memo unless cols.size == 3

  # Add industry details
  memo << {
    :code => cols[0],
    :groups => cols[1].split(/\s+/),
    :description => cols[2]
  }

  # Next line
  memo
end

# Dump to various formats
{
  # JSON
  'js' => industries
}
