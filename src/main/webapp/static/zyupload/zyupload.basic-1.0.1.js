/**
 * zyupload.basic.js-HTML5 multi-file upload basic functional js code, does not include drag and drop upload, cropping pictures and other functions
 * Currently contains 2 specific parts
 * 1. zyFile.js - the data processing layer called by zyupload
 * 2. zyUpload.js - the business layer called by zyupload
 */



var ZYFILE = {
	fileInput : null,
	uploadInput : null,
	dragDrop: null,
	url : "",
	uploadFile : [],
	lastUploadFile : [],
	perUploadFile : [],
	fileNum : 0,
	customData : "",

	filterFile : function(files){
		return files;
	},
	onSelect : function(selectFile, files){
		
	},
	onDelete : function(file, files){
		
	},
	onProgress : function(file, loaded, total){
		
	},
	onSuccess : function(file, responseInfo){
		
	},
	onFailure : function(file, responseInfo){
	
	},
	onComplete : function(responseInfo){
		
	},
	// Provide an external interface for filtering file formats, etc., and the external needs to return the filtered file
// Provide external access to selected files for external preview and other functions selectFile: currently selected files allFiles: all files that have not been uploaded yet
// Provide a single file to be deleted externally for external implementation of the delete effect file: the currently deleted file files: the deleted file
// Provide external access to the upload progress of a single file for external implementation of the upload progress effect
	// Provided to the outside to obtain the successful upload of a single file for the outside to achieve a successful effect
// Provided to the outside to obtain a single file upload failure, for the outside to achieve the failure effect
	// Provide external access to complete upload of all files for external implementation to complete the effect

	/* Internal realization function method */
// Get the selected file
//File drag and drop
	funDragHover: function(e) {
		e.stopPropagation();
		e.preventDefault();
		this[e.type === "dragover"? "onDragOver": "onDragLeave"].call(e.target);
		return this;
	},
	// Get files
	funGetFiles : function(e){  
		var self = this;
		// Cancel the mouse passing style
		this.funDragHover(e);
		// Get all selected files from the event
		var files = e.target.files || e.dataTransfer.files;
		self.lastUploadFile = this.uploadFile;
		this.uploadFile = this.uploadFile.concat(this.filterFile(files));
		var tmpFiles = [];

		// Because the inArray method of jquery cannot determine whether the object array exists, so you can only extract the name for judgment
		var lArr = [];
		var uArr = [];
		$.each(self.lastUploadFile, function(k, v){
			lArr.push(v.name);
		});
		$.each(self.uploadFile, function(k, v){
			uArr.push(v.name);
		});
		
		$.each(uArr, function(k, v){
			// Get each file currently selected to determine whether the current file exists in the previous file
			if($.inArray(v, lArr) < 0){
				tmpFiles.push(self.uploadFile[k]);
			}
		});

		// If tmpFiles has performed the operation of filtering the last selected file, you need to assign the filtered file
//if(tmpFiles.length!=0){
			this.uploadFile = tmpFiles;


		// Call the method of file processing
		this.funDealtFiles();
		
		return true;
	},
	// Process the filtered files and set subscripts for each file
	funDealtFiles : function(){
		var self = this;

		$.each(this.uploadFile, function(k, v){
			// Because it involves continuing to add, the next addition needs to be added on the basis of the total number
			v.index = self.fileNum;
			self.fileNum++;
		});

		var selectFile = this.uploadFile;  

		this.perUploadFile = this.perUploadFile.concat(this.uploadFile);

		this.uploadFile = this.lastUploadFile.concat(this.uploadFile);
		

		this.onSelect(selectFile, this.uploadFile);
		console.info("Continue to choose");
		console.info(this.uploadFile);
		return this;
	},
	// Process the files that need to be deleted isCb represents whether to call back the onDelete method
// Because the upload is complete and you don’t want to delete the div on the page, but you need to delete the div when you click delete alone, so use isCb to judge
	funDeleteFile : function(delFileIndex, isCb){
		var self = this;
		
		var tmpFile = [];

		var delFile = this.perUploadFile[delFileIndex];
		//console.info(delFile);
// currently iterate through all files, compare each file delete
		$.each(this.uploadFile, function(k, v){
			if(delFile != v){
				// If it is not the deleted file, put it in the temporary array
				tmpFile.push(v);
			}
		});
		this.uploadFile = tmpFile;
		if(isCb){  /// execute callback
// Call back the delete method for external implementation of the delete effect
			self.onDelete(delFile, this.uploadFile);
		}
		
		console.info("These files have not been uploaded:");
		console.info(this.uploadFile);
		return true;
	},

	funUploadFiles : function(){
		var self = this;  //This points to no v in each, so keep this first
// Traverse all files, calling the method of uploading a single file
		$.each(this.uploadFile, function(k, v){
			self.funUploadFile(v);
		});
	},

	funUploadFile : function(file){
		var self = this;
		var formdata = new FormData();
		formdata.append("file", file);	
		formdata.append("customData", ZYFILE.customData);
		// Add the cropped coordinates and width and height to the background
		if($("#uploadTailor_"+file.index).length>0){
			formdata.append("tailor", $("#uploadTailor_"+file.index).attr("tailor"));	
		}
		var xhr = new XMLHttpRequest();
		// Bind upload event
// progress
	    xhr.upload.addEventListener("progress",	 function(e){
	    	self.onProgress(file, e.loaded, e.total);
	    }, false); 

	    xhr.addEventListener("load", function(e){
    		/// Delete the successfully uploaded file from the file. False means not to execute the onDelete callback method
	    	self.funDeleteFile(file.index, false);
			// Call back to the outside
	    	self.onSuccess(file, xhr.responseText);
	    	if(self.uploadFile.length==0){
				// Callback all completed method
	    		self.onComplete("fully completed");
	    	}
	    }, false);  

	    xhr.addEventListener("error", function(e){
	    	self.onFailure(file, xhr.responseText);
	    }, false);  
		
		xhr.open("POST",self.url, true);
		xhr.send(formdata);
	},
// Return the file to be uploaded
	funReturnNeedFiles : function(){
		return this.uploadFile;
	},

	init : function(){  // Initialization method, here bind events to select and upload buttons
		var self = this;
		
		if (this.dragDrop) {
			this.dragDrop.addEventListener("dragover", function(e) { self.funDragHover(e); }, false);
			this.dragDrop.addEventListener("dragleave", function(e) { self.funDragHover(e); }, false);
			this.dragDrop.addEventListener("drop", function(e) { self.funGetFiles(e); }, false);
		}

		if(self.fileInput){
			this.fileInput.addEventListener("change", function(e) {
				self.funGetFiles(e); 
			}, false);	
		}

		if(self.uploadInput){
			this.uploadInput.addEventListener("click", function(e) {
				self.funUploadFiles(e); 
			}, false);	
		}
	}
};



(function($,undefined){
	$.fn.zyUpload = function(options,param){
		var otherArgs = Array.prototype.slice.call(arguments, 1);
		if (typeof options == 'string') {
			var fn = this[0][options];
			if($.isFunction(fn)){
				return fn.apply(this, otherArgs);
			}else{
				throw ("zyUpload - No such method: " + options);
			}
		}

		return this.each(function(){
			var para = {};    // keep parameters
			var self = this;
			
			var defaults = {
					width            : "700px",
					height           : "400px",
					itemWidth        : "140px",
					itemHeight       : "120px",
					url              : "/upload/UploadAction",
					fileType         : [],
					fileSize         : 51200000,
					multiple         : true,
					dragDrop         : false,
//					edit             : true,
					tailor           : false,
					del              : true,
					finishDel        : false,
					customData       : {},
				/* Provide external interface method */
					onSelect         : function(selectFiles, allFiles){},
					onDelete		 : function(file, files){},
					onSuccess		 : function(file, response){},
					onFailure		 : function(file, response){},
					onComplete		 : function(response){}
				/*
 onSelect: function(selectFiles, allFiles){}, // Callback method for selecting files selectFile: currently selected files allFiles: all files that have not been uploaded
onDelete: function(file, files)(), // callback method for deleting a file file: currently deleted file files: deleted file
onSuccess: function(file, response){}, // callback method for successful file upload
onFailure: function(file, response){}, // callback method for file upload failure
onComplete: function(response){} // callback method for upload completion
*/
			};
			
			para = $.extend(defaults,options);
			
			this.init = function(){
				this.createHtml();
				this.createCorePlug();
			};
			

			this.createHtml = function(){
				var multiple = "";
				para.multiple ? multiple = "multiple" : multiple = "";
				var html= '';
				
				if(para.dragDrop){

					html += '<form id="uploadForm" action="'+para.url+'" method="post" enctype="multipart/form-data">';
					html += '	<div class="upload_box">';
					html += '		<div class="upload_main">';
					html += '			<div class="upload_choose">';
	            	html += '				<div class="convent_choice">';
	            	html += '					<div class="andArea">';
	            	html += '						<div class="filePicker">Click to select file</div>';
	            	html += '						<input id="fileImage" type="file" size="30" name="fileselect[]" '+multiple+'>';
	            	html += '					</div>';
	            	html += '				</div>';
					html += '				<span id="fileDragArea" class="upload_drag_area">Or drag the file here</span>';
					html += '			</div>';
		            html += '			<div class="status_bar">';
		            html += '				<div id="status_info" class="info">Select 0 files, a total of 0B.</div>';
		            html += '				<div class="btns">';
		            html += '					<div class="webuploader_pick">Continue to choose</div>';
		            html += '					<div class="upload_btn">Start uploading files</div>';
		            html += '				</div>';
		            html += '			</div>';
					html += '			<div id="preview" class="upload_preview"></div>';
					html += '		</div>';
					html += '		<div class="upload_submit">';
					html += '			<button type="button" id="fileSubmit" class="upload_submit_btn">Confirm upload file</button>';
					html += '		</div>';
					html += '		<div id="uploadInf" class="upload_inf"></div>';
					html += '	</div>';
					html += '</form>';
				}else{
					var imgWidth = parseInt(para.itemWidth.replace("px", ""))-15;
					

					html += '<form id="uploadForm" action="'+para.url+'" method="post" enctype="multipart/form-data">';
					html += '	<div class="upload_box">';
					html += '		<div class="upload_main single_main">';
		            html += '			<div class="status_bar">';
		            html += '				<div id="status_info" class="info">Select 0 files, a total of 0B.</div>';
		            html += '				<div class="btns">';
		            html += '					<input id="fileImage" type="file" size="30" name="fileselect[]" '+multiple+'>';
		            html += '					<div class="webuploader_pick">Select the files</div>';
		            html += '					<div class="upload_btn">Start uploading files</div>';
		            html += '				</div>';
		            html += '			</div>';
		            html += '			<div id="preview" class="upload_preview">';
				    html += '				<div class="add_upload">';
				    html += '					<a style="height:'+para.itemHeight+';width:'+para.itemWidth+';" title="Click here to add file" id="rapidAddImg" class="add_imgBox" href="javascript:void(0)">';
				    html += '						<div class="uploadImg" style="width:'+imgWidth+'px">';
				    html += '							<img class="upload_image" src="zyupload/skins/images/add_img.png" style="width:expression(this.width > '+imgWidth+' ? '+imgWidth+'px : this.width)" />';
				    html += '						</div>'; 
				    html += '					</a>';
				    html += '				</div>';
					html += '			</div>';
					html += '		</div>';
					html += '		<div class="upload_submit">';
					html += '			<button type="button" id="fileSubmit" class="upload_submit_btn">Confirm upload file</button>';
					html += '		</div>';
					html += '		<div id="uploadInf" class="upload_inf"></div>';
					html += '	</div>';
					html += '</form>';
				}
				
	            $(self).append(html).css({"width":para.width,"height":para.height});

	            this.addEvent();
			};

			this.funSetStatusInfo = function(files){
				var size = 0;
				var num = files.length;
				$.each(files, function(k,v){
					size += v.size;
				});

				if (size > 1024 * 1024) {                    
					size = (Math.round(size * 100 / (1024 * 1024)) / 100).toString() + 'MB';                
				} else {                    
					size = (Math.round(size * 100 / 1024) / 100).toString() + 'KB';                
				}  
				

				$("#status_info").html("Select"+num+"files，a total of"+size+".");
			};
			

			this.funFilterEligibleFile = function(files){
				var arrFiles = [];
				for (var i = 0, file; file = files[i]; i++) {
					var newStr = file.name.split("").reverse().join("");
					if(newStr.split(".")[0] != null){
						var type = newStr.split(".")[0].split("").reverse().join("");
						if(jQuery.inArray(type, para.fileType) > -1){
							// The type matches, you can upload
							if (file.size >= para.fileSize) {
								alert('Your"'+ file.name +'"file size is too large');
							} else {
								// Need to judge all current files here
								arrFiles.push(file);	
							}
						}else{
							alert('Your file"'+ file.name +'"upload type does not match');
						}
					}else{
						alert('Your"'+ file.name +'"file has no type and cannot be recognized');
					}
				}
				return arrFiles;
			};
			

			this.funDisposePreviewHtml = function(file, e){
				var html = "";
				var imgWidth = parseInt(para.itemWidth.replace("px", ""))-15;
				var imgHeight = parseInt(para.itemHeight.replace("px", ""))-10;

				// Process configuration parameter edit and delete buttons
				var editHtml = "";
				var delHtml = "";
				
				if(para.tailor){  // Show the crop button
					editHtml = '<span class="file_edit" data-index="'+file.index+'" title="edite"></span>';
				}
				if(para.del){  // Show the delete button
					delHtml = '<span class="file_del" data-index="'+file.index+'" title="delete"></span>';
				}
				
				var newStr = file.name.split("").reverse().join("");
				var type = newStr.split(".")[0].split("").reverse().join("");
				var fileImgSrc = "zyupload/skins/images/fileType/";
				if(type == "rar"){
					fileImgSrc = fileImgSrc + "rar.png";
				}else if(type == "zip"){
					fileImgSrc = fileImgSrc + "zip.png";
				}else if(type == "txt"){
					fileImgSrc = fileImgSrc + "txt.png";
				}else if(type == "ppt"){
					fileImgSrc = fileImgSrc + "ppt.png";
				}else if(type == "xls"){
					fileImgSrc = fileImgSrc + "xls.png";
				}else if(type == "pdf"){
					fileImgSrc = fileImgSrc + "pdf.png";
				}else if(type == "psd"){
					fileImgSrc = fileImgSrc + "psd.png";
				}else if(type == "ttf"){
					fileImgSrc = fileImgSrc + "ttf.png";
				}else if(type == "swf"){
					fileImgSrc = fileImgSrc + "swf.png";
				}else{
					fileImgSrc = fileImgSrc + "file.png";
				}
				

				if (file.type.indexOf("image") == 0) {
					html += '<div id="uploadList_'+ file.index +'" class="upload_append_list">';
					html += '	<div class="file_bar">';
					html += '		<div style="padding:5px;">';
					html += '			<p class="file_name" title="'+file.name+'">' + file.name + '</p>';
					html += 			editHtml;
					html += 			delHtml;
					html += '		</div>';
					html += '	</div>';
					html += '	<a style="height:'+para.itemHeight+';width:'+para.itemWidth+';" href="#" class="imgBox">';
					html += '		<div class="uploadImg" style="width:'+imgWidth+'px;max-width:'+imgWidth+'px;max-height:'+imgHeight+'px;">';				
					html += '			<img id="uploadImage_'+file.index+'" class="upload_image" src="' + e.target.result + '" style="width:expression(this.width > '+imgWidth+' ? '+imgWidth+'px : this.width);" />';                                                                 
					html += '		</div>';
					html += '	</a>';
					html += '	<p id="uploadProgress_'+file.index+'" class="file_progress"></p>';
					html += '	<p id="uploadFailure_'+file.index+'" class="file_failure">Upload failed, please try again</p>';
					html += '	<p id="uploadTailor_'+file.index+'" class="file_tailor" tailor="false">Cropping is complete</p>';
					html += '	<p id="uploadSuccess_'+file.index+'" class="file_success"></p>';
					html += '</div>';
                	
				}else{
					html += '<div id="uploadList_'+ file.index +'" class="upload_append_list">';
					html += '	<div class="file_bar">';
					html += '		<div style="padding:5px;">';
					html += '			<p class="file_name">' + file.name + '</p>';
					html += 			delHtml;
					html += '		</div>';
					html += '	</div>';
					html += '	<a style="height:'+para.itemHeight+';width:'+para.itemWidth+';" href="#" class="imgBox">';
					html += '		<div class="uploadImg" style="width:'+imgWidth+'px">';				
					html += '			<img id="uploadImage_'+file.index+'" class="upload_file" src="' + fileImgSrc + '" style="width:expression(this.width > '+imgWidth+' ? '+imgWidth+'px : this.width)" />';                                                                 
					html += '		</div>';
					html += '	</a>';
					html += '	<p id="uploadProgress_'+file.index+'" class="file_progress"></p>';
					html += '	<p id="uploadFailure_'+file.index+'" class="file_failure">Upload failed, please try again</p>';
					html += '	<p id="uploadSuccess_'+file.index+'" class="file_success"></p>';
					html += '</div>';
				}
				
				return html;
			};
			

			this.createPopupPlug = function(imgSrc, index, name){

				$("body").zyPopup({
					src        :   imgSrc,
					index      :   index,
					name       :   name,
					onTailor   :   function(val, quondamImgInfo){     //the callback returns the coordinates of the crop and the values ​​of width and height
// Do the preview processing of the successfully cropped image
						var nWidth = parseInt(para.itemWidth.replace("px", ""));
						var nHeight = parseInt(para.itemHeight.replace("px", ""));
						var qWidth = val.width;
						var qHeight = val.height;

						var ratio = nWidth / qWidth;
						var width = ratio * quondamImgInfo.width;
						var height = ratio * quondamImgInfo.height;
						var left = val.leftX * ratio;
						var top  = val.rightY * ratio - qHeight * ratio;
						
						$("#uploadImage_" + index).css({
							"width"    : width,
							"height"   : height,
							"margin-left" : -left,
							"margin-top" : -top
						});
						
						$("#uploadTailor_" + index).show();    
						console.info(val);
						var tailor = "{'leftX':"+val.leftX+",'leftY':"+val.leftY+",'rightX':"+val.rightX+",'rightY':"+val.rightY+",'width':"+val.width+",'height':"+val.height+"}";
//						$.getScript("jquery.json-2.4.js", function(){
//							$("#uploadTailor_" + index).attr("tailor",$.toJSON(val));
//						});
						$("#uploadTailor_" + index).attr("tailor",tailor);
					}
				});
			};

			this.createCorePlug = function(){
				var customDataStr = "";
				$.each(para.customData, function(key, val){
					customDataStr += key+":"+val+";";
				});
				
				var params = {
					fileInput: $("#fileImage").get(0),
					uploadInput: $("#fileSubmit").get(0),
					dragDrop: $("#fileDragArea").get(0),
					url: $("#uploadForm").attr("action"),
					customData: encodeURI(encodeURI(customDataStr)),
					
					filterFile: function(files) {
						return self.funFilterEligibleFile(files);
					},
					onSelect: function(selectFiles, allFiles) {
						para.onSelect(selectFiles, allFiles);
						self.funSetStatusInfo(ZYFILE.funReturnNeedFiles());
						var html = '', i = 0;
						var funDealtPreviewHtml = function() {
							file = selectFiles[i];
							if (file) {
								var reader = new FileReader();
								reader.onload = function(e) {
									html += self.funDisposePreviewHtml(file, e);
									
									i++;
									funDealtPreviewHtml();
								}
								reader.readAsDataURL(file);
							} else {
								funAppendPreviewHtml(html);
							}
						};
						

						var funAppendPreviewHtml = function(html){
							if(para.dragDrop){
								$("#preview").append(html);
							}else{
								$(".add_upload").before(html);
							}
							funBindDelEvent();
							funBindHoverEvent();
						};

						var funBindDelEvent = function(){
							if($(".file_del").length>0){
								$(".file_del").click(function() {
									ZYFILE.funDeleteFile(parseInt($(this).attr("data-index")), true);
									return false;	
								});
							}
							
							if($(".file_edit").length>0){

									$(".file_edit").click(function() {
										var imgIndex = $(this).attr("data-index");
										var imgName = $(this).prev(".file_name").attr("title");
										var imgSrc = $("#uploadImage_"+imgIndex).attr("src");
										self.createPopupPlug(imgSrc, imgIndex, imgName);
										return false;	
									});
//								}
							}
						};

						var funBindHoverEvent = function(){
							$(".upload_append_list").hover(
								function (e) {
									$(this).find(".file_bar").addClass("file_hover");
								},function (e) {
									$(this).find(".file_bar").removeClass("file_hover");
								}
							);
						};
						
						funDealtPreviewHtml();		
					},
					onDelete: function(file, files) {
						para.onDelete(file, files);
						$("#uploadList_" + file.index).fadeOut();

						self.funSetStatusInfo(files);
						console.info("Remaining files");
						console.info(files);
					},
					onProgress: function(file, loaded, total) {
						var eleProgress = $("#uploadProgress_" + file.index), percent = (loaded / total * 100).toFixed(2) + '%';
						if(eleProgress.is(":hidden")){
							eleProgress.show();
						}
						eleProgress.css("width",percent);
					},
					onSuccess: function(file, response) {
						para.onSuccess(file, response);
						$("#uploadProgress_" + file.index).hide();
						$("#uploadSuccess_" + file.index).show();

						if(para.finishDel){

							$("#uploadList_" + file.index).fadeOut();
							self.funSetStatusInfo(ZYFILE.funReturnNeedFiles());
						}
						if($("#uploadTailor_"+file.index).length>0){
							$("#uploadTailor_" + file.index).hide();
						}
					},
					onFailure: function(file, response) {
						para.onFailure(file, response);
						$("#uploadProgress_" + file.index).hide();
						$("#uploadSuccess_" + file.index).show();
						if($("#uploadTailor_"+file.index).length>0){
							$("#uploadTailor_" + file.index).hide();
						}
						$("#uploadInf").append("<p>File" + file.name + "upload failed！</p>");
					},
					onComplete: function(response){
						para.onComplete(response);
						console.info(response);
					},
					onDragOver: function() {
						$(this).addClass("upload_drag_hover");
					},
					onDragLeave: function() {
						$(this).removeClass("upload_drag_hover");
					}

				};
				
				ZYFILE = $.extend(ZYFILE, params);
				ZYFILE.init();
			};

			this.addEvent = function(){
				if($(".filePicker").length > 0){
					$(".filePicker").bind("click", function(e){
		            	$("#fileImage").click();
		            });
				}
	            

				$(".webuploader_pick").bind("click", function(e){
	            	$("#fileImage").click();
	            });
				

				$(".upload_btn").bind("click", function(e){

					if(ZYFILE.funReturnNeedFiles().length > 0){
						$("#fileSubmit").click();
					}else{
						alert("Please select the file and click upload");
					}
	            });
				

				if($("#rapidAddImg").length > 0){
					$("#rapidAddImg").bind("click", function(e){
						$("#fileImage").click();
		            });
				}
			};
			

			this.init();
		});
	};
})(jQuery);

