require 'Util'

-- TilesMap object
TilesMap = {}
-- meta method
TilesMap.__index = TilesMap

BRICK = 1
EMPTY = 29

-- constructor
function TilesMap:create()
    local this = {
        -- texture containing sprites is in graphics folder
        spritesMap = love.graphics.newImage('graphics/tiles.png'),
        -- dimension of a tile
        tileWidth = 16,
        tileHeight = 16,
        -- dimension of the map
        tilesMapWidth = 30,
        tilesMapHeight = 28,
        -- create the table and store its reference
        tiles = {}
    }

    -- generate a quad for each tile on the sprites texture
    this.sprites = generateQuads(this.spritesMap, this.tileHeight, this.tileWidth)

    -- width and height of map in pixels
    this.mapWidthPixels = this.mapWidth * this.tileWidth
    this.mapHeightPixels = this.mapHeight * this.tileHeight

    -- more OO boilerplate -> class functions
    setmetatable(this, self)

    -- fill map with empty tiles
    for y = 1, this.mapHeight do
        for x = 1, this.mapWidth do
            -- set that tile to be our empty tile defined above
            -- use function for setting tiles
            this:setTile(x,y,EMPTY)
        end
    end
    -- -- fill bottom half of map with tiles
    for y = this.mapHeight / 2, this.mapHeight do
        for x = 1, this.mapWidth do
            -- set that tile to be our brick tile defined above
            this:setTile(x,y,BRICK)
        end
    end
    return this
end

-- returns an integer value for the tile at a given x-y coordinate
function Map:getTile(x, y)
    return self.tiles[(self.mapWidth * (y-1)) + x)]
end

-- sets a tile at a given x-y coordinate to an integer value
function Map:setTile(x, y, tile)
    -- assign a tile ID at a given X, Y coordinate in this class
    -- calculate the index given an X and Y value
    tile = self.tiles[(self.mapWidth * (y-1)) + x)]
end

-- renders our map to the screen, to be called by main's render
function Map:render()
    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            -- draw to the screen the tile at X, Y
            love.graphics.draw(self.spritesMap, self.sprites[self:getTile(x,y), (x-1) * self.tileWidth, (y-1) * self.tileHeight])
        end
    end
end