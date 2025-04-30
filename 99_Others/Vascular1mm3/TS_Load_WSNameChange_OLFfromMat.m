function Image = TS_Load_WSNameChange_OLFfromMat(Fname)

load(Fname)
vname = Fname;
vname(end-3:end) = [];
Image = eval(vname);