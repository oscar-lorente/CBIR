function imageFriends = getImageFriends (imageName, imaDB)
  for i = 1:4
     imageFriends(i, :) = imaDB(find(strcmp({imaDB.name}, imageName)==1)+i-1).name;
  end
end