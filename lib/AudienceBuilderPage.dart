import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudienceBuilderModel extends ChangeNotifier {
  List<AudienceRule> _rules = [];
  int _audienceSize = 0;

  List<AudienceRule> get rules => _rules;
  int get audienceSize => _audienceSize;

  void addRule(AudienceRule rule) {
    _rules.add(rule);
    notifyListeners();
  }

  void removeRule(int index) {
    _rules.removeAt(index);
    notifyListeners();
  }

  void updateAudienceSize() {
    // Simulate audience size calculation
    _audienceSize = _rules.length * 1000;
    notifyListeners();
  }
}

class AudienceRule {
  final String field;
  final String condition;
  final String value;

  AudienceRule(this.field, this.condition, this.value);
}

class AudienceBuilderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audience Builder'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: AudienceRulesList(),
            ),
            AudienceSummary(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save the audience
                print('Audience saved');
              },
              child: Text('Save Audience'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddRuleDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddRuleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final fieldController = TextEditingController();
        final conditionController = TextEditingController();
        final valueController = TextEditingController();

        return AlertDialog(
          title: Text('Add Rule'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: fieldController,
                decoration: InputDecoration(labelText: 'Field'),
              ),
              TextField(
                controller: conditionController,
                decoration: InputDecoration(labelText: 'Condition'),
              ),
              TextField(
                controller: valueController,
                decoration: InputDecoration(labelText: 'Value'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final field = fieldController.text;
                final condition = conditionController.text;
                final value = valueController.text;

                if (field.isNotEmpty && condition.isNotEmpty && value.isNotEmpty) {
                  Provider.of<AudienceBuilderModel>(context, listen: false)
                      .addRule(AudienceRule(field, condition, value));
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class AudienceRulesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AudienceBuilderModel>(
      builder: (context, model, child) {
        return ListView.builder(
          itemCount: model.rules.length,
          itemBuilder: (context, index) {
            final rule = model.rules[index];
            return ListTile(
              title: Text('${rule.field} ${rule.condition} ${rule.value}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  model.removeRule(index);
                },
              ),
            );
          },
        );
      },
    );
  }
}

class AudienceSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AudienceBuilderModel>(
      builder: (context, model, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Audience Size: ${model.audienceSize}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                model.updateAudienceSize();
              },
              child: Text('Check Audience Size'),
            ),
          ],
        );
      },
    );
  }
}
