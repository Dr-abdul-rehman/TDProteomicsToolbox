function final_score()
   
result=getappdata(0,'Matches');
w1=getappdata(0,'w1');
w2=getappdata(0,'w2');
w3=getappdata(0,'w3');
for num_prot=1:numel(result)
    MW_Score=result{num_prot}.MWScore;
    PST_Score=result{num_prot}.EST_Score;
    Insilico_frag_Score=result{num_prot}.Matches_Score;
    final_score=((w1*MW_Score)+(w2*PST_Score)+(w3*Insilico_frag_Score))/3;% calculating final score 
    result{num_prot}.Final_Score=final_score;
end
    setappdata(0,'Matches',result);
               