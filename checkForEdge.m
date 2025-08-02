function gxy = checkForEdge(x,y,edges,epsilon)

    gxy =  1 / ( 1+edges(x,y))  >= epsilon;

end

