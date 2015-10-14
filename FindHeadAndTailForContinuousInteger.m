function BoxStartandEndPos = FindHeadAndTailForContinuousInteger(BoxID_tobecombined)
%% input: an incrsing Int array.
%% Output: an 2-row Array that Row1 represents the start of a Box while Row 2 the end of it.

m = size(BoxID_tobecombined,2);
idx = 1;

%initialize the Start End Position and PointerValue
pl = BoxID_tobecombined(1);
pr = BoxID_tobecombined(1);
pvalue = pl;

for i = 1: m-1
    if BoxID_tobecombined(i+1) == pvalue + 1;
        pvalue = BoxID_tobecombined(i+1);
        pr = pr + 1;
        if(i+1 == m)
            BoxStartandEndPos(:,idx) = [pl;pr];
            return;
        end
    else
        %store this box and reset pl pr and pvalue;
        BoxStartandEndPos(:,idx) = [pl;pr];
        idx = idx + 1;
        pl = BoxID_tobecombined(i + 1);
        pr = BoxID_tobecombined(i + 1);
        pvalue = pl;
    end
end