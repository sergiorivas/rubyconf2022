raise if ['apples',33,nil,'hat','tomatoes','toothbrush','laptop'].select{|d|d.is_a?(String)&&d.size>5&&d!='tomatoes'}!=%w[apples toothbrush laptop];p'It works!'
