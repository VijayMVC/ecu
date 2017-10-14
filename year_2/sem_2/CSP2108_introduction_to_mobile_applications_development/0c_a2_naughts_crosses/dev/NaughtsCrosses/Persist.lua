local Persist = class("Persist");

function Persist:init()
    self.filename = "score.json";
    self.path = system.DocumentsDirectory;
    self.filepath = system.pathForFile(self.filename, self.path);

    if(not self:doesFileExist(self.filepath)) then
        self:newFile(self.filepath);
    end
end

function Persist:doesFileExist(filepath)
    local file = io.open(filepath, "r");
    if(not file) then
        return false;
    end
    io.close(file);
    file = nil;
    return true;
end

function Persist:loadScores()
    local scores = self:read(self.filepath);
    if(scores) then
        return scores;
    else
        return self:resetScores();
    end
end

function Persist:saveScores(scores)
    self:write(self.filepath, scores);
end

function Persist:resetScores()
    local scores = {
        win = 0;
        loss = 0;
        draw = 0;
    };
    self:write(self.filepath, scores);
    return scores;
end

function Persist:read(filepath)
    local file, errorMessage = io.open(filepath, "r");
    local object = nil;
    if(file) then
        logger:debug(self.name, "read()", string.format("Read file: %s", filepath));
        local deserialized = file:read("*a");
        logger:debug(self.name, "read()", string.format("Deserialize json to object: '%s'", deserialized));
        object = _json.decode(deserialized);
    else
        logger:debug(self.name, "read()", string.format("Error reading file: %s", errorMessage));
    end
    io.close(file);
    file = nil;
    return object;
end

function Persist:newFile(filepath)
    local file, errorMessage = io.open(filepath, "w");
    if(file) then
        logger:debug(self.name, "newFile()", string.format("Create new file: %s", filepath));
        file:write("");
    else
        logger:debug(self.name, "newFile()", string.format("Error creating new file: %s", errorMessage));
    end
    io.close(file);
    file = nil;
end

function Persist:write(filepath, object)
    local file, errorMessage = io.open(filepath, "w");
    local isWrite = false;
    if(file) then
        local serialized = _json.encode(object);
        logger:debug(self.name, "write()", string.format("Serialize object to json: '%s'", serialized));
        file:write(serialized);
        logger:debug(self.name, "write()", string.format("Write file: %s", filepath));
        isWrite = true;
    else
        logger:debug(self.name, "write()", string.format("Error writing file: %s", errorMessage));
    end
    io.close(file);
    file = nil;
    return isWrite;
end

return Persist;