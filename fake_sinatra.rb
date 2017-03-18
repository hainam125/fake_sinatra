def get(path, &block)
	middleware = Class.new
	middleware.send(:define_method, 'initialize') do |app|
		@app = app
	end

	middleware.send(:define_method, "call") do |env|
		if env['REQUEST_METHOD'] == 'GET'&& env['REQUEST_PATH'] == self.class.path
			action
		else
			@app.call env
		end
	end

	middleware.instance_eval do
		def path=(path)
			@path = path
		end

		def path
			@path
		end
	end

	middleware.send(:define_method, "action", &block)

	middleware.path = path

	use middleware
end