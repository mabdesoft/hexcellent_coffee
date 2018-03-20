###
 * Copyright 2011 Matthew Delaney
 * 
 * This file is part of Hexcellent.
 *
 * Hexcellent is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Hexcellent is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Hexcellent.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Filename: Hexcellent.js
 * Purpose : A drawable hexagonal grid with point location (e.g. which cell is the point (u, v) in?)
 * Date    : 31/7/2011
 * @author Matthew Delaney
###
class window.Hexcellent
    constructor: (aCellSize, aWidth, aHeight, aLeft, aTop) ->
        @grid = new Array()
        @cellSize = aCellSize // The width of a single hexagonal cell
        @gridWidth = aWidth
        @gridHeight = aHeight
        @left = aLeft
        @top = aTop

        # Create a dummy hexagon to get offset-values for positioning
        @h = new Hexagon(cellSize, 0, 0)
        @horizOffset = h.getH()*2+h.getA()*2
        @verticOffset = h.getO()
        @evenLineOffset = h.getH()+h.getA()

        # Create the grid in memory
        for i in [0..@gridHeight]
            @grid[i] = new Array()
            for j in [0..@gridWidth]
                if i%2 == 0 # Offset every other row to give tessallation
                    @grid[i][j] = new Hexagon(cellSize, (j*horizOffset+evenLineOffset)+left, ((i+1)*verticOffset)+top)
                else
                    @grid[i][j] = new Hexagon(cellSize, (j*horizOffset)+left, ((i+1)*verticOffset)+top)


    # Given a 2D drawing context on an HTML5 <canvas> tag, draw the grid
    draw: (context) ->
        for i in [0..@gridHeight]
            for j in [0..@gridWidth]
                @grid[i][j].draw context
	
    # Find the cell containing point (u, v)
    findCell: (u, v) ->
        retval = null
		
        for i in [0..@gridHeight]
            for j in [0..@gridWidth]
                if @grid[i][j].contains u, v
                    retval = @grid[i][j]
		    
                    # Add grid coordinates of cell to returned object
                    retval.gridX = j
                    retval.gridY = i
		    
        return retval
