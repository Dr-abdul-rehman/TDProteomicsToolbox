function [Final_EST_Score,Tag_indices] = PST_Score(Tags_ladder,Sequence)
%% Scan database protein sequence for ESTs
    Tag_indices = false;
    Final_EST_Score = 0 ;
    number_of_tags_found = 0;
    for num = 1 : numel(Tags_ladder) % for number of tags in the tag ladder
        
        tag=Tags_ladder{1, num}{1, 1}; % search for tag in the sequence
        if ~isempty(strfind(Sequence,tag))
            Tag_indices = true;
            number_of_tags_found = number_of_tags_found + 1;
           no_of_occournaces = length(strfind(Sequence,tag));
            if(isnan(Tags_ladder{1, num}{1, 4}))
                Final_EST_Score = Final_EST_Score +(no_of_occournaces*(  Tags_ladder{1, num}{1, 2} + Tags_ladder{1, num}{1, 3}));
            else
                Final_EST_Score = Final_EST_Score +(no_of_occournaces*( Tags_ladder{1, num}{1, 2 } + Tags_ladder{1, num}{1, 3} + Tags_ladder{1, num}{1, 4})); % simple sum right now
            end
        end
    end
    Final_EST_Score = Final_EST_Score / numel(Sequence);
end