package com.example.kaomia.ui.screens.profile

import android.util.Log
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.wrapContentSize
import androidx.compose.foundation.layout.wrapContentWidth
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.CornerSize
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Text
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavController
import com.example.kaomia.R
import com.example.kaomia.Screen
import com.example.kaomia.core.Tools
import com.example.kaomia.core.Tools.CardTitle
import com.example.kaomia.core.Tools.getKernelElementDrawable
import com.example.kaomia.core.Tools.saveExplorerData
import com.example.kaomia.models.Element
import com.example.kaomia.models.Explorer
import com.example.kaomia.ui.composables.LoadingSpinner
import com.example.kaomia.ui.theme.FirstComposeTheme
import com.example.kaomia.ui.theme.OffWhite
import androidx.compose.runtime.setValue
import com.example.kaomia.models.LoginResponse
import com.example.kaomia.models.Tokens
var isVisible by mutableStateOf(true)
@Composable
fun ProfileScreen(navController: NavController) {
   val logoutViewModel: LogoutViewModel = viewModel()
   val logoutUIState by logoutViewModel.logoutUIState.collectAsState()

   val profileViewModel: ProfileViewModel = viewModel()
   val profileUIState by profileViewModel.profileUIState.collectAsState()

   val context = LocalContext.current
   val explorerData by Tools.getExplorerData(context).collectAsState(initial = null)

   LaunchedEffect(true) {
      explorerData?.explorer?.let {
         profileViewModel.retrieveExplorer(explorerData!!.tokens, it.href)
      }
   }

   Column {
      when (val state = logoutUIState) {
         is LogoutUIState.Error -> {
            Log.d("Error", state.exception.toString())
         }
         LogoutUIState.Loading -> Unit
         is LogoutUIState.Success -> {
            LaunchedEffect(true) {
               saveExplorerData(context, null)
               navController.navigate(Screen.Login.route)
            }
         }
      }

      when (val state = profileUIState) {
         is ProfileUIState.Error -> {
            Log.d("Error", state.exception.toString())
         }
         ProfileUIState.Loading -> {
            Column(
               modifier = Modifier.fillMaxSize(),
               horizontalAlignment = Alignment.CenterHorizontally,
               verticalArrangement = Arrangement.Center
            ) {
               LoadingSpinner()
            }
         }
         is ProfileUIState.Success -> {
            ExplorerView(state.explorer)
         }
      }
   }
}

@Composable
fun Header(explorer: Explorer) {

   val logoutViewModel: LogoutViewModel = viewModel()
   val context = LocalContext.current
   val explorerData by Tools.getExplorerData(context).collectAsState(initial = null)

   if(isVisible){
      Card(modifier = Modifier
         .wrapContentSize()
         .height(610.dp),
         shape = RoundedCornerShape(16.dp),
         colors = CardDefaults.cardColors(containerColor = OffWhite.copy(alpha = 0.5f))) {
         CardTitle(title = "Mon Profil")
         Column(
            modifier = Modifier.fillMaxHeight(),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.SpaceEvenly
         ) {
            Card(modifier = Modifier
               .width(250.dp)
               .wrapContentSize()) {
               CardTitle(title = "nom d'utilisateur")
               Text(text = explorer.username, fontSize = 25.sp)
            }
            Card(modifier = Modifier
               .width(250.dp)
               .wrapContentSize()) {
               CardTitle(title = "nom complet")
               Text(text = explorer.name + " " + explorer.surname, fontSize = 20.sp)
            }
            Card(modifier = Modifier
               .width(250.dp)
               .wrapContentWidth()) {
               CardTitle(title = "courriel")
               Text(text = explorer.email, fontSize = 20.sp, modifier = Modifier.wrapContentWidth())
            }
            Row(
               modifier = Modifier.fillMaxWidth(),
               horizontalArrangement = Arrangement.SpaceEvenly
            ) {

               Card(modifier = Modifier.width(125.dp)){
                  CardTitle(stringResource(id =  R.string.explorer_inox))
                  Text(text = explorer.inventory.inox.toString(), fontSize = 20.sp )
               }
               Card(modifier = Modifier.width(125.dp)){
                  CardTitle(title = stringResource(id =R.string.explorer_location ))
                  Text(text = explorer.location, fontSize = 20.sp)
               }

            }


            // Button to disconnect Explorer
            Button(onClick = {
               //logoutViewModel.logoutExplorer(loginResponse.tokens)
               explorerData?.let { it.tokens }?.let { logoutViewModel.logoutExplorer(it) }
            }) {
               Text(stringResource(id = R.string.disconnect))
            }

         }

      }
      Button(onClick = {
         //logoutViewModel.logoutExplorer(loginResponse.tokens)
         isVisible = false
      }) {
         Text("Afficher mon inventaire")
      }
      }
   }








@Composable
fun BackgroundImage() {
   Image(
      painter = painterResource(id = R.drawable.island),
      contentDescription = null,
      contentScale = ContentScale.FillBounds,
      modifier = Modifier
         .fillMaxSize()
         .size(160.dp)
         .background(
            color = Color.White,
            shape = CircleShape
         )
   )
}


@Composable
fun ExplorerView(explorer: Explorer) {
   Box(
      modifier = Modifier.fillMaxSize()
   ) {
      BackgroundImage()
      Column(
         modifier = Modifier
            .padding(16.dp),
         horizontalAlignment = Alignment.CenterHorizontally
      ) {
         Header(explorer)
         ElementsInventory(explorer)
      }
   }
}

@Composable
fun ElementsInventory(explorer: Explorer) {
   if(!isVisible){
      Card(
         modifier = Modifier
            .wrapContentSize()
            .height(610.dp),
         shape = RoundedCornerShape(16.dp),
         colors = CardDefaults.cardColors(containerColor = OffWhite.copy(alpha = 0.5f))
      ) {
         CardTitle(stringResource(id = R.string.my_elements))
         LazyVerticalGrid(
            columns = GridCells.Fixed(4),
            contentPadding = PaddingValues(8.dp),
            verticalArrangement = Arrangement.Top
         ) {
            items(explorer.inventory.elements) { element ->
               ElementView(element)
            }
         }


      }
      Button(onClick = {
         //logoutViewModel.logoutExplorer(loginResponse.tokens)
         isVisible=true
      }) {
         Text("Afficher mon profil")
      }
   }

}

@Composable
fun ElementView(element: Element) {
   Card(
      modifier = Modifier
         .wrapContentSize()
         .padding(4.dp),
      elevation = CardDefaults.cardElevation(defaultElevation = 6.dp),
      shape = RoundedCornerShape(corner = CornerSize(8.dp)),
      colors = CardDefaults.cardColors(containerColor = OffWhite)
   ) {
      ElementName(element)
      ElementDrawable(element)
      ElementQuantity(element)
   }
}

@Composable
fun ElementName(element: Element) {
   Box(modifier = Modifier
      .fillMaxWidth()
      .background(Color.DarkGray)
   ) {
      Text(
         text = element.element,
         textAlign = TextAlign.Center,
         fontWeight = FontWeight.Bold,
         fontSize = 15.sp,
         modifier = Modifier
            .padding(0.dp, 8.dp, 0.dp, 8.dp)
            .fillMaxWidth(),
         color = Color.White
      )
   }
}

@Composable
fun ElementDrawable(element: Element) {
   Image(
      painter = painterResource(getKernelElementDrawable(element.element)),
      contentDescription = null,
      modifier = Modifier
         .fillMaxWidth()
         .padding(8.dp, 0.dp, 8.dp, 0.dp),
      contentScale = ContentScale.FillWidth
   )
}

@Composable
fun ElementQuantity(element: Element) {
   Text(
      text = "× ${element.quantity}",
      textAlign = TextAlign.Center,
      modifier = Modifier
         .padding(8.dp, 0.dp, 8.dp, 8.dp)
         .fillMaxWidth()
   )
}
