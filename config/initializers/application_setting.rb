class Setting

  def initialize
    cfname = File.join(Rails::root, 'config', 'settings.yml')
    raise "No file '#{cfname}' found." unless File.exist?(cfname)
    data = YAML.load(File.new(cfname))
    env = Rails.env
    @default_data = data['default']
    @data = data[Rails.env]
    raise "No entry '#{Rails.env}' or 'default' in file '#{cfname}'" if !@default_data.present? && !@data.present?
  end

  def self.[](sid)
    @_instance ||= new()
    @_instance[sid]
  end

  def [](sid)
    names = sid.split('.')
    dat = (names.inject([@default_data, @data]) do |d, nam|
      dd, ad = d
      [dd.is_a?(Hash) ? dd[nam] : nil, ad.is_a?(Hash) ? ad[nam] : nil]
    end)
    return dat[1] if dat[1]
    return dat[0] if dat[0]
    raise "No entry for key '#{sid}' in settings."
  end

end
