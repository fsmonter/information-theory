function sf = shannonfano(probabilities)
limit = size(probabilities,1);

 if limit == 1
     sf = probabilities(1,:)
     return;
 end
 
 if limit == 2
   probabilities(1,3) = strcat(probabilities(1,3), '1');
   probabilities(1,3) = probabilities(1,3)
   
   probabilities(2,3) = strcat(probabilities(2,3), '0');
   probabilities(2,3) = probabilities(2,3)
   sf = [probabilities(1:2,:)];
   return;
 end

format rat;

x = cell2mat(probabilities(1:limit,1))
half = sum(x)/2
sumatory = 0;
next_limit = 1;

    for i = 1:length(probabilities()) 
        sumatory = sumatory + probabilities{i,1};
        if sumatory < half
           probability = strcat(probabilities(i,3), '1');
           probabilities(i,3) = probability
           next_limit = i;
        else
           probability = strcat(probabilities(i,3), '0');
           probabilities(i,3) = probability
        end
    end
    next_limit
    %Call for upper side
    upper = [probabilities(1:next_limit,:)]
    probabilities(1:next_limit,:) = shannonfano(upper)
    
    %Call for down side} 
    downside = [probabilities(next_limit + 1:limit,:)]
    probabilities(next_limit + 1:limit,:) = shannonfano(downside)
    
    sf = probabilities(1:limit,:)
end
