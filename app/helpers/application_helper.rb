module ApplicationHelper
def get_banking_with_select(lov_name)
  return [["Select", "" ]]+ BNK[lov_name];
#    return [LOVs[lov_name]];
end
BNK = {
"brabch_name" =>[
      ["Chennai","1"],["Mumbai","2"],["Bangalorge","3"],["Delhi","4"],["Madural","5"],["KKD","6"]
    ],
"brabch_code" =>[
      ["1","1"],["2","2"],["3","3"],["4","4"],["5","5"],["6","6"]
    ],    
}
end
