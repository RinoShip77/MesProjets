import mongoose from 'mongoose';
import bcrypt from 'bcrypt';

const technicianSchema = new mongoose.Schema({
  email: {
    type: String,
    required: [ true, 'The email is required'],
    unique: true,
    lowercase: true,
    trim: true,
    match: [/^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/, 'Enter a valid email address']
  },
  name: {
    type: String,
    required: true,
    maxlength: 255
  },
  level: {
    type: Number,
    min: 1,
    max: 3,
    default: 1
  },
  password: {
    type: String,
    required: [true, 'The password is required'],
    minlength: [8, 'The password must contains 8 characters minimum'],
    select: false // Règle d'or : exclut ce champ par défaut des requêtes GET pour éviter les fuites
  }
}, {
  versionKey: false,
  toJSON: {
    transform: function (doc, ret) {
      delete ret.password;
      return ret;
    }
  },
  toObject: {
    transform: function (doc, ret) {
      delete ret.password;
      return ret;
    }
  }
});

// Hook Mongoose : Hache le mot de passe avant chaque sauvegarde si modifié
technicianSchema.pre('save', async function() {
  // Si le mot de passe n'est pas modifié, on sort simplement de la fonction
  if (!this.isModified('password')) return;
  
  // Plus besoin de try/catch ou de next(), Mongoose gère la promesse
  const salt = await bcrypt.genSalt(10);
  this.password = await bcrypt.hash(this.password, salt);
});

// 2. Intercepter le createMany (insertMany)
// En Mongoose 7+, une fonction async reçoit directement les documents en 1er paramètre
technicianSchema.pre('insertMany', async function (docs) {
  const salt = await bcrypt.genSalt(10);
  
  for (let doc of docs) {
    if (doc.password) {
      doc.password = await bcrypt.hash(doc.password, salt);
    }
  }
});

// 3. Intercepter les mises à jour partielles (updateOne, updateMany, findOneAndUpdate)
// Retrait du paramètre 'next' et de son appel
const hashPasswordForUpdate = async function () {
  const update = this.getUpdate();
  
  if (!update) return;

  // On vérifie si un mot de passe est présent dans la requête de mise à jour
  if (update.password || (update.$set && update.$set.password)) {
    const salt = await bcrypt.genSalt(10);
    
    // Cas 1 : Le mot de passe est directement à la racine de l'update
    if (update.password) {
      update.password = await bcrypt.hash(update.password, salt);
    }
    // Cas 2 : Le mot de passe est dans un opérateur $set (comportement MongoDB par défaut)
    else if (update.$set && update.$set.password) {
      update.$set.password = await bcrypt.hash(update.$set.password, salt);
    }
  }
};

technicianSchema.pre('updateOne', hashPasswordForUpdate);
technicianSchema.pre('updateMany', hashPasswordForUpdate);
technicianSchema.pre('findOneAndUpdate', hashPasswordForUpdate);

// Méthode d'instance : Compare le mot de passe fourni avec le hash stocké
technicianSchema.methods.matchPassword = async function (enteredPassword) {
  return await bcrypt.compare(enteredPassword, this.password);
};

export default mongoose.model('Technician', technicianSchema);