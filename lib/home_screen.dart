import 'package:flutter/material.dart';
import 'package:sqli/db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: ()async{
              int i = await DatabaseHelper.instance.insert({
                DatabaseHelper.Colname : 'Sugam',
                DatabaseHelper.Colage : 18
              });
              debugPrint(i.toString());
            },
              child: const Text('Insert'),

            ),
            TextButton(onPressed: ()async{
              List<Map<String,dynamic>> queryRows = await DatabaseHelper.instance.query(4 );
              debugPrint(queryRows.toString());

            },
              child: const Text('Query Specific'),

            ),
            TextButton(onPressed: ()async{
               List<Map<String,dynamic>> queryRows = await DatabaseHelper.instance.queryAll();
               debugPrint(queryRows.toString());

            },
              child: const Text('Query'),

            ),
            TextButton(onPressed: ()async{
              int updatedRows = await DatabaseHelper.instance.update({
                DatabaseHelper.Colid : 2,
                DatabaseHelper.Colage : 6,
                DatabaseHelper.Colname : 'Sugam Paudel'
              });
              debugPrint(updatedRows.toString());
            },
                child: Text('Update')),
              TextButton(onPressed: ()async{
               int deletedRows =  await DatabaseHelper.instance.delete(3);
               debugPrint('$deletedRows');
              },

                child: Text('Delete'),),
              ],
        ),
      ),
    );
  }
}
