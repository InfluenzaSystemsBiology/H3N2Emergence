
function Process_Data()
clear;clc;
%% Read TestSeq (Date without month and day will be abandoned)
[Name, Sequence] = Get_TestSeq();
[VNode, Abd_idx] = Parse_Name(Name);
VNode(Abd_idx) = [];
Sequence(Abd_idx) = [];
VNode = Combine_VS(VNode, Sequence);
VNode = SortVNode(VNode);

fprintf('Loaded %d testing sequences...\n',length(VNode));

%% read vaccine seq
[Name, Sequence] = Get_VaccineSeq();
[VNode_vaccine] = Parse_Name(Name);
VNode_vaccine = Combine_VS(VNode_vaccine, Sequence);
VNode = [VNode VNode_vaccine];

fprintf('Loaded %d vaccine sequences...\n',length(VNode_vaccine));

save V.mat VNode
end

function VNode = Combine_VS(VNode, Sequence)
N = length(VNode);
for i = 1:N
    VNode(i).Seq = Sequence{i};
end
end

function VNode = SortVNode(VNode)
N = length(VNode);
DN = zeros(1, N);
for i = 1:N
    fprintf('%d\n', i);
    DN(i) = VNode(i).dn;
end
[~, idx] = sort(DN, 'ascend');
VNode = VNode(idx);
end

function [VNode, Abandoned_idx] = Parse_Name(Name)
n = length(Name);
Abandoned_idx = zeros(1, n);
VNode = struct;
for i = 1:n
    str = Name{i};
    stickIDX = strfind(str, '||');
    if ~isempty(stickIDX)
        tmpcomp = strsplit(str, '/');
        tmploc = tmpcomp{2};
        str = strcat( str(1:stickIDX), tmploc, str(stickIDX+1:end) );
    end
    Component = strsplit(str, '|');
    VNode(i).ID = Component{1};
    VNode(i).Location = Component{3};
    Sub_Com = strsplit(Component{4}, '-');
    DateLen = length(Sub_Com);
    if DateLen == 3
        y = str2num( Sub_Com{1} );
        m = str2num( Sub_Com{2} );
        d = str2num( Sub_Com{3} );
        if isempty(y) || y < 1950 || y > 2020 || m < 1 || m > 12
            Abandoned_idx(i) = 1;
            continue;
        end
        if isempty(d)
            d = 1;
        end
        if isempty(m)
            d = 1;
        end
        VNode(i).Date = datetime(y, m, d);
        VNode(i).Y = y;
        VNode(i).M = m;
        VNode(i).D = d;
        VNode(i).dn = datenum( VNode(i).Date );
    elseif DateLen == 2
        y = str2num( Sub_Com{1} );
        m = str2num( Sub_Com{2} );
        if isempty(y) || y < 1950 || y > 2020 || m < 1 || m > 12
            Abandoned_idx(i) = 1;
            continue;
        end
        if isempty(d)
            d = 1;
        end
        if isempty(m)
            d = 1;
        end
        VNode(i).Date = datetime(y, m, d);
        VNode(i).Y = y;
        VNode(i).M = m;
        VNode(i).D = d;
        VNode(i).dn = datenum( VNode(i).Date );
    else
        y = str2num( Sub_Com{1} );
        m = 1;
        d = 1;
        VNode(i).Date = datetime(y, m, d);
        VNode(i).Y = y;
        VNode(i).M = m;
        VNode(i).D = d;
        VNode(i).dn = datenum( VNode(i).Date );
    end
    fprintf('No.: %d, ID: %s, Location: %s, Date: %s\n', ...
        i, VNode(i).ID, VNode(i).Location, datestr( VNode(i).Date ) );
end
Abandoned_idx = logical(Abandoned_idx);
end


function [Name, Sequence] = Get_TestSeq()
fid = fopen('1968-2018.fasta','r');
top = 0;
Name = cell(1);
Sequence = cell(1);
while true
    str = fgetl(fid);
    if ischar(str) == 0 || isempty(str)
        break;
    end
    if str(1) == '>'
        top = top + 1;
        Name{top} = str(2:end);
        fprintf('Number: %d, Virus: %s\n', top, Name{top});
        Sequence{top} = '';
    else
        Sequence{top} = strcat(Sequence{top}, str);
        fprintf('Seq: %s\n', Sequence{top});
    end
end
fclose(fid);
end


function [Name Sequence] = Get_VaccineSeq()
fid = fopen('history_vaccine.fasta','r');
top = 0;
Name = cell(1);
Sequence = cell(1);
while true
    str = fgetl(fid);
    if ischar(str) == 0 || isempty(str)
        break;
    end
    if str(1) == '>'
        top = top + 1;
        Name{top} = str(2:end);
        fprintf('Number: %d, Virus: %s\n', top, Name{top});
        Sequence{top} = '';
    else
        Sequence{top} = strcat(Sequence{top}, str);
        fprintf('Seq: %s\n', Sequence{top});
    end
end
fclose(fid);
end


