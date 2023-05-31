clear all
cvx_solver mosek
cvx_precision medium

load CQ_random_state_sigmas.mat

tic
cvx_begin sdp
    variables p1 p2 p3 p4 p5 p6 p7 p8 p9 p10;
    maximize(quantum_entr(p1*sigma{1} + p2*sigma{2} + p1*sigma{3} + p1*sigma{4} + p1*sigma{5} + p1*sigma{6} + p1*sigma{7} + p1*sigma{8} + p1*sigma{9} + p1*sigma{10})...
            - p1*quantum_entr(sigma{1}) - p2*quantum_entr(sigma{2}) - p3*quantum_entr(sigma{3}) - p4*quantum_entr(sigma{4}) - p5*quantum_entr(sigma{5}) - p6*quantum_entr(sigma{6})...
            - p7*quantum_entr(sigma{7}) - p8*quantum_entr(sigma{8}) - p9*quantum_entr(sigma{9}) - p10*quantum_entr(sigma{10}))
subject to
    p1 + p2 + p3 + p4 + p5 + p6 + p7 + p8 + p9 + p10 == 1;
    p2 >= 0;
    p3 >= 0;
    p4 >= 0;
    p5 >= 0;
    p6 >= 0;
    p7 >= 0;
    p8 >= 0;
    p9 >= 0;
    p10 >= 0;
cvx_end
toc

cvx_slvtol