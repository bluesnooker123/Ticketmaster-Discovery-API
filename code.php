<?php
/**
events (includes name, type, id, test, url, locale, sales, dates) done
events_presales (presales)
events_products (products)

*/
	$conn = mysqli_connect("localhost","root","","json");

	$curl = curl_init();

	curl_setopt_array($curl, array(
	  CURLOPT_URL => 'https://app.ticketmaster.com/discovery/v2/events.json?countryCode=US&apikey=V7Ifxhe3bJvrmhxO2G2NyitUpAAAAxP4',
	  CURLOPT_RETURNTRANSFER => true,
	  CURLOPT_ENCODING => '',
	  CURLOPT_MAXREDIRS => 10,
	  CURLOPT_TIMEOUT => 0,
	  CURLOPT_SSL_VERIFYHOST=> false,
	  CURLOPT_SSL_VERIFYPEER=> false,
	  CURLOPT_FOLLOWLOCATION => true,
	  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	  CURLOPT_CUSTOMREQUEST => 'GET',
	));

	 $response = curl_exec($curl);

	$jsonArr = json_decode($response,true);
	//echo "<pre>";
	//print_r($jsonArr);

	foreach($jsonArr['_embedded']['events'] as $key => $val){
		//check event
		$checkEvent = mysqli_query($conn,"select * from events where id ='".$val['id']."'");
		if(mysqli_num_rows($checkEvent)>0){
			// update event
			$startDateTime = (isset($salesArr['public']['startDateTime']))?$salesArr['public']['startDateTime']:'';
			$startTBD = (isset($salesArr['public']['startTBD']))?$salesArr['public']['startTBD']:'';
			$startTBA = (isset($salesArr['public']['startTBA']))?$salesArr['public']['startTBA']:'';
			$endDateTime = (isset($salesArr['public']['endDateTime']))?$salesArr['public']['endDateTime']:'';
			
			$eventData = mysqli_fetch_assoc($checkEvent);
			
			$updateDataArr = array();
			if($eventData['name']!=$val['name']){
				$updateDataArr['name'] = array("old_value"=>$eventData['name'],"new_value"=>$val['name']);
			}
			if($eventData['type']!=$val['type']){
				$updateDataArr['type'] = array("old_value"=>$eventData['type'],"new_value"=>$val['type']);
			}
			if($eventData['id']==$val['id']){
				$updateDataArr['id'] = array("old_value"=>$eventData['id'],"new_value"=>$val['id']);
			}
			if($eventData['test']!=$val['test']){
				$updateDataArr['test'] = array("old_value"=>$eventData['test'],"new_value"=>$val['test']);
			}
			if($eventData['url']!=$val['url']){
				$updateDataArr['url'] = array("old_value"=>$eventData['url'],"new_value"=>$val['url']);
			}
			if($eventData['locale']!=$val['locale']){
				$updateDataArr['locale'] = array("old_value"=>$eventData['locale'],"new_value"=>$val['locale']);
			}
			
			if($eventData['startDateTime']!=$startDateTime){
				$updateDataArr['startDateTime'] = array("old_value"=>$eventData['locale'],"new_value"=>$startDateTime);
			}
			if($eventData['startTBD']!=$startTBD){
				$updateDataArr['startTBD'] = array("old_value"=>$eventData['startTBD'],"new_value"=>$startTBD);
			}
			if($eventData['startTBA']!=$startTBA){
				$updateDataArr['startTBA'] = array("old_value"=>$eventData['startTBA'],"new_value"=>$startTBA);
			}
			if($eventData['endDateTime']!=$endDateTime){
				$updateDataArr['endDateTime'] = array("old_value"=>$eventData['endDateTime'],"new_value"=>$endDateTime);
			}
			
			$updateEvent = mysqli_query($conn,"update events set name = '".$val['name']."',type='".$val['id']."',id='".$val['id']."',test='".$val['test']."',url='".$val['url']."',locale='".$val['locale']."',startDateTime='$startDateTime',startTBD='$startTBD',startTBA='$startTBA',endDateTime='$endDateTime' where id = '".$val['id']."'");
			
			if(mysqli_affected_rows($updateEvent)>0){
				echo "record updated";
				
			}
			
			//add dates
			$eventDates = $val['dates'];
			if(count($eventDates)>0){
				$getDates = mysqli_fetch_assoc(mysqli_query($conn,"select * from events_dates where events_id =".$eventData['events_id']));
				
				
				
				
				$start = $eventDates['start'];
				$status = $eventDates['status'];
				$timezone = (isset($eventDates['timezone']))?$eventDates['timezone']:'';
				$insertDates = mysqli_query($conn,"insert into events_dates (events_id, `localDate`, `localTime`, `dateTime`, dateTBD, dateTBA, timeTBA, noSpecificTime, timezone, code, spanMultipleDays)values($eventID,'".$start['localDate']."','".$start['localTime']."','".$start['dateTime']."','".$start['dateTBD']."','".$start['dateTBA']."','".$start['timeTBA']."','".$start['noSpecificTime']."','".$timezone."','".$status['code']."','".$eventDates['spanMultipleDays']."');"); 
			}
			
		}else{
			//insert event
			
			$startDateTime = (isset($salesArr['public']['startDateTime']))?$salesArr['public']['startDateTime']:'';
			$startTBD = (isset($salesArr['public']['startTBD']))?$salesArr['public']['startTBD']:'';
			$startTBA = (isset($salesArr['public']['startTBA']))?$salesArr['public']['startTBA']:'';
			$endDateTime = (isset($salesArr['public']['endDateTime']))?$salesArr['public']['endDateTime']:'';
			
			$insertEvent = mysqli_query($conn,"insert into events(name,type,id,test,url,locale, startDateTime, startTBD, startTBA, endDateTime)values('".$val['name']."','".$val['type']."','".$val['id']."','".$val['test']."','".$val['url']."','".$val['locale']."','$startDateTime','$startTBD','$startTBA','$endDateTime')");
			
			$eventID = mysqli_insert_id($conn);
			
			/*add sales*/
			$salesArr = $val['sales'];
			//add presales
				if(isset($salesArr['presales'])){
					$salesPresalesArr = $salesArr['presales'];
					if(count($salesPresalesArr)>0){
						foreach($salesPresalesArr as $presalesKey=>$presalesValue){
							$insertPresales = mysqli_query($conn,"insert into events_sales_presales (events_id, startDateTime, endDateTime, name)values('$eventID','".$presalesValue['startDateTime']."','".$presalesValue['endDateTime']."','".$presalesValue['name']."')");
						}
					}
				}
			/*add salses end*/
			
			//add dates
			$eventDates = $val['dates'];
			if(count($eventDates)>0){
				$start = $eventDates['start'];
				$status = $eventDates['status'];
				$timezone = (isset($eventDates['timezone']))?$eventDates['timezone']:'';
				$insertDates = mysqli_query($conn,"insert into events_dates (events_id, `localDate`, `localTime`, `dateTime`, dateTBD, dateTBA, timeTBA, noSpecificTime, timezone, code, spanMultipleDays)values($eventID,'".$start['localDate']."','".$start['localTime']."','".$start['dateTime']."','".$start['dateTBD']."','".$start['dateTBA']."','".$start['timeTBA']."','".$start['noSpecificTime']."','".$timezone."','".$status['code']."','".$eventDates['spanMultipleDays']."');"); 
			}
			
			//add products
			if(isset($val['products'])){
				$productArr = $val['products'];
				
				if(count($productArr)>0){
					foreach($productArr as $keyProduct=>$valProduct){
						$name = $valProduct['name'];
						$id = $valProduct['id'];
						$url = $valProduct['url'];
						$type = $valProduct['type'];
						$classificationsArr1 = $valProduct['classifications'];
						
						$insertProduct = mysqli_query($conn,"insert into events_products(events_id,name,id,url,type)values('$eventID','$name','$id','$url','$type')");
						$productID = mysqli_insert_id($conn);
						
						if(count($classificationsArr1)>0){
							foreach($classificationsArr1 as $classKey=>$classVal){
								$segment = $classVal['segment'];
								$genre = $classVal['genre'];
								$subGenre = $classVal['subGenre'];
								$type = $classVal['type'];
								$subType = $classVal['subType'];
							
								$insertClassification = mysqli_query($conn,"insert into events_products_classifications_id ( events_product_id,events_id, `primary`, segment_id, segment_name, genre_id, genre_name, subGenre_id, subGenre_name, type_id, type_name, subType_id, subType_name, family)values($productID,$eventID,'".$classVal['primary']."','".$segment['id']."','".$segment['name']."','".$genre['id']."','".$genre['name']."','".$subGenre['id']."','".$subGenre['name']."','".$type['id']."','".$type['name']."','".$subType['id']."','".$subType['name']."','".$classVal['family']."')");
								
								
							}
						}
					}
				}
			}
		}
	}

?>