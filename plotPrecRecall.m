function plotPrecRecall(prec, recall, M, Fscore, prog)
    [idealPrec, idealRecall] = getIdealPrecRecall(size(prec, 2), M);
    figure;
    plot(idealRecall, idealPrec, 'black', 'LineWidth', 1.5);
    xlabel('Recall');
    ylabel('Precision');
    legend(['[F = 1] ', 'Ideal']);
    hold on
    if(prog == 1)
        legendString = 'Bhattacharyya distance';
    else
        legendString = 'CLD - 18 coef.';
    end
    plot(recall, prec, 'blue', 'LineWidth', 1.5, 'DisplayName', ['[F = ', num2str(round(Fscore,3)),'] ', legendString]);
    legend('off');
    legend('show');
    axis([0 1 0 1]);
    grid on;
end