import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance; // for authentication
FirebaseFirestore firestore = FirebaseFirestore.instance; // for getting or entering data in storage
User? user = auth.currentUser; // for getting current user data

// collection
const userCollection = 'users';
const productCollection = 'products';
const cartCollection = 'cart';
const chatCollection = 'chat';
const orderCollection = 'orders';
const messageCollection = 'messages';
