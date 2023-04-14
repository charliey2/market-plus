local function createInstance(className: string, instanceProps: { string: any }?): Instance
    if not className or typeof(className) ~= "string" then -- assert but without the performance issues
        error("[Utility][Create]: invalid arg #1, string expected", 2)
    end

    local new: Instance = Instance.new(className)

    for propName: string, propValue: any in instanceProps do
        if propName == "Parent" then
            continue -- setting the Parent property should always been done last!
        end
        new[propName] = propValue
    end

    if instanceProps.Parent then
        new.Parent = instanceProps.Parent
    end

    return new
end

return {
    Create = createInstance
}