function getData(){
    url = "https://youtube.googleapis.com/youtube/v3/search?part=snippet&channelId=UC6RzukLXWGBx6dOGqzaeK5w&q=%5Bv2%5D%2090%20Minutes%20of%20Focused%20Studying%3A%20The%20Best%20Binaural%20Beats&key=AIzaSyBoIGPynrDQQ80DrJ-39xwvcSlqfR7b_ys";
    data = '{"[v2] 90 Minutes of Focused Studying: The Best Binaural Beats"}'
    params = {
        headers:{
            'Content-Type':'application/json'
        },
        body: JSON.stringify(data),
    }
    fetch(url,params).then((response)=>{
        return response.json();
    }).then((data)=>{
        console.log(data);
    })
}
getData()