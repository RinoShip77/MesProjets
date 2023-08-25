//{
//    name:"nouveau",
//    position:{
//        x:125,
//        y:125
//    }
//}
//Va nous permettre d'accéder à des données à l'intérieur d'un objet
//{
//    name:"nouveau",
//    position.x:125,
//    position.y:125
//}

export default (args) =>{
    const setObject = {};

    Object.keys(args).forEach((key)=>{
        if (typeof args[key] ==='object'){
            Object.keys(args[key]).forEach((subkey) => {
                setObject[`${key}.${subkey}`] = args[key][subkey];
            });
        } else{
            setObject[key] = args[key];
        }
    });
    
    return setObject;
}