function writeResults(outFile, imageName, sortedImages, imaDB)
  fprintf(outFile, 'Retrieved list for query image %s\n', imageName);
  for i = 1:size(sortedImages, 2)
    fprintf(outFile, '%s\n', imaDB(sortedImages(2,i)).name);
  end
  fprintf(outFile,'\n');
end