class Application
    @@items =[Item.new("apple", "90"), Item.new("figs", "90")]
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item_title = req.path.split("/items/").last
            if @@items.any? {|item| item.name == item_title}
                resp.write @@items.find{|s| s.name == item_title}.price
            else
                resp.write "Item not found"
                resp.status = 400
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end
end 