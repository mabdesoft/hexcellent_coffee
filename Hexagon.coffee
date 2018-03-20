###
Copyright 2011-2018 Matthew Delaney
  
   This file is part of Hexcellent.
 
   Hexcellent is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
  
   Hexcellent is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
  
   You should have received a copy of the GNU General Public License
   along with Hexcellent.  If not, see <http://www.gnu.org/licenses/>.
     
   Filename: Hexagon.coffee
   Purpose : A drawable hexagon class with point-membership (i.e. is point (u, v) in this hexagon?)
   Date    : 25/08/2013
   @author Matthew Delaney
###

class window.Hexagon
    constructor: (aSize, anX, aY) ->
        if aSize < 0
            throw new RangeError "Size cannot be negative!"
        else if anX < 0
            throw new RangeError "X-coordinate cannot be negative!"
        else if aY < 0
            throw new RangeError "Y-coordinate cannot be negative!"
        
        @TANSIXTY = Math.tan 2*Math.PI/360*60
        @size = aSize
        @x = anX
        @y = aY
        
        @a = @size/4
        @h = @size/4*2
        @o = @TANSIXTY*@a
        
    getSize: ->
        return @size
        
    setSize: (aSize) ->
        @size = aSize

    getA: ->
        return @a
    
    setA: (anA) ->
        @a = anA

    getH: ->
        return @h
    
    setH: (anH) ->
        @h = anH

    getO: ->
        return @o
    
    setO: (anO) ->
        @o = anO

    getX: ->
        return @x
    
    setX: (anX) ->
        @x = anX
    
    getY: ->
        return @y
    
    setY: (aY) ->
        @y = ay
    
    draw: (context) ->
        do context.beginPath
        context.moveTo @x, @y
        context.lineTo @x+@a, @y-@o
        context.lineTo @x+@a+@h, @y-@o
        context.lineTo @x+@a+@a+@h, @y
        context.lineTo @x+@a+@h, @y+@o
        context.lineTo @x+@a, @y+@o
        context.lineTo @x, @y
        do context.fill
        do context.stroke
        do context.closePath
    
    contains: (u, v) ->
        retval = false

    	# Box in centre of hexagon
        inBox = u >= (@x+@a) && u <= (@x+@a+@h) && v >= (@y-@o) && v <= (@y+@o)

		# Triangle to the left of box
        inLeftTriangle = u >= @x && u <= @x + @a && v >= @y - (u - @x) * @TANSIXTY && v <= @y + (u - @x) * @TANSIXTY

		# Triangle to the right of box
        inRightTriangle = u >= @x + @a + @h && u <= @x + @a + @h + @a && v >= @y - (@x + @a + @h + @a - u) * @TANSIXTY && v <= @y + (@x + @a + @h + @a - u) * @TANSIXTY

        if inLeftTriangle || inBox || inRightTriangle
            retval = true
        
        return retval