//@ File (label="Input directory",style="directory") inputdir
//@ File (label="Output directory",style="directory") outputdir
//@ string (label="File type", choices={".czi",".nd2",".ome.tiff",".tif"}, style="listBox") Type

//save input roiset as filename-tor-roiset.zip and saved in the inputdir/ROI


list = getFileList(inputdir);


for (i=0; i<list.length; i++) {
    showProgress(i+1, list.length);
    filename = inputdir + File.separator+ list[i];
    Folder_ROI =inputdir + File.separator+ "ROI";
    Folder_Tortuosity = outputdir +File.separator+ "1-Tortuosity";
    
    if(Type == ".ome.tiff" ){
    Fname_temp = File.getNameWithoutExtension(filename);
    Fname = File.getNameWithoutExtension(Fname_temp);   
    }
    else{
     Fname = File.getNameWithoutExtension(filename);   	
    	}
     Rname = Fname + "-tor-roiset.zip";
    File.makeDirectory(Folder_Tortuosity);
    
    print("\\Clear");
	roiManager("reset");
	roiManager("Show None");
	run("Clear Results");
	run("Collect Garbage");

    print(filename);
    print(list[i]);


	if (endsWith(filename, Type)) {
        roiManager("reset");
        run("Bio-Formats Importer", "open=" + filename + " autoscale color_mode=Default view=Hyperstack stack_order=XYCZT");
        
        run("Select None");
        id = getImageID();
        
        roiManager("reset");
		roiManager("Open", Folder_ROI+File.separator+Rname);
		
		CellRoi = roiManager("count");
		GeoDArray = newArray(CellRoi);
		FeretDArray = newArray(CellRoi);
		TorArray = newArray(CellRoi);
		
		for (j = 0; j < CellRoi; j++) {
			
			nCell = j+1;
			pad_nCell = IJ.pad(nCell, 3);
			
			roiManager("select", j);
			frame=getSliceNumber();
			roiManager("rename", "line-"+nCell+"-Frame"+frame);
			run("Create Mask");
			saveAs("Tiff", outputdir+File.separator+Fname+"-Line"+pad_nCell+"-frame"+frame+"-mask.tif");
			mask = getImageID();
			title = getTitle();
			run("Skeleton Geodesic Diameter", "input="+title+ " chamfer=[Quasi-Euclidean (1,1.41)] show image="+title+" export");
			
			saveAs("Results", Folder_Tortuosity+File.separator+Fname+"-Line"+pad_nCell+"-frame"+frame+"-SkelGeodDiam.csv");
			GeoD = Table.get("GeodesicDiameter",0);
			GeoDArray[j] = GeoD;
			
			if (!File.exists(Folder_Tortuosity+ File.separator + Fname + "-GeoD-append.csv")) {
			print("\\Clear");
			print(GeoD);
			selectWindow("Log");
			saveAs("txt", Folder_Tortuosity+ File.separator + Fname + "-GeoD-append.csv");
			};
			else {
			File.append(GeoD, Folder_Tortuosity+ File.separator + Fname + "-GeoD-append.csv");
			print("\\Clear");
			}
			
			run("Max. Feret Diameters", "input="+title+ "chamfer=[Quasi-Euclidean (1,1.41)] show image="+title+" export");
			saveAs("Results", Folder_Tortuosity+File.separator+Fname+"-Line"+pad_nCell+"-frame"+frame+"-FeretDiams.csv");
			FeretD = Table.get("Diameter",0);
			FeretDArray[j] = FeretD;
			
			if (!File.exists(Folder_Tortuosity+ File.separator + Fname + "-FeretD-append.csv")) {
			print("\\Clear");
			print(FeretD);
			selectWindow("Log");
			saveAs("txt", Folder_Tortuosity+ File.separator + Fname + "-FeretD-append.csv");
			};
			else {
			File.append(FeretD, Folder_Tortuosity+ File.separator + Fname + "-FeretD-append.csv");
			print("\\Clear");
			}
			
			Tor = GeoD/FeretD;
			TorArray[j] = Tor;
			
			if (!File.exists(Folder_Tortuosity+ File.separator + Fname + "-Tor-append.csv")) {
			print("\\Clear");
			print(Tor);
			selectWindow("Log");
			saveAs("txt", Folder_Tortuosity+ File.separator + Fname + "-Tor-append.csv");
			};
			else {
			File.append(Tor, Folder_Tortuosity+ File.separator + Fname + "-Tor-append.csv");
			print("\\Clear");
			}
			
			close("*.csv");
			selectImage(mask);
			close();
			
		}
		print("\\Clear");
		Array.print(GeoDArray);
		selectWindow("Log");
		saveAs("txt", Folder_Tortuosity+ File.separator + Fname + "-GeoD-full.csv");
		print("\\Clear");
		Array.print(FeretDArray);
		selectWindow("Log");
		saveAs("txt", Folder_Tortuosity+ File.separator + Fname + "-FeretD-full.csv");
		print("\\Clear");
		Array.print(TorArray);
		selectWindow("Log");
		saveAs("txt", Folder_Tortuosity+ File.separator + Fname + "-Tor-full.csv");
		print("\\Clear");
		
	close("*");
	run("Close All");	
		
	}
}