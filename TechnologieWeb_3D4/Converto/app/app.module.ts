import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';

import { AppComponent } from './app.component';
import { DimensionsComponent } from './dimensions/dimensions.component';
import { PoidsComponent } from './poids/poids.component';
import { TemperaturesComponent } from './temperatures/temperatures.component';
import { MonnaieComponent } from './monnaie/monnaie.component';
import { FormsModule } from '@angular/forms';

@NgModule({
  declarations: [
    AppComponent,
    DimensionsComponent,
    PoidsComponent,
    TemperaturesComponent,
    MonnaieComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
